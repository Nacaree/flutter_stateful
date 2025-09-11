import 'package:flutter/material.dart';
import 'package:learn_stateful/ReadWriteData/article_model.dart';
import 'package:learn_stateful/ReadWriteData/article_service.dart';
import 'package:learn_stateful/ReadWriteData/article_update.dart';
import 'package:learn_stateful/ReadWriteData/article_write.dart';

class ArticlePage extends StatefulWidget {
  const ArticlePage({super.key});

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  late Future<ArticleModel> futureArticles;

  @override
  void initState() {
    super.initState();
    futureArticles = getArticles();
  }

  void _refreshArticles() {
    setState(() {
      futureArticles = getArticles();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Articles")),
      body: FutureBuilder<ArticleModel>(
        future: futureArticles,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.articles.isEmpty) {
            return const Center(child: Text("No articles found"));
          }

          final articles = snapshot.data!.articles;

          return ListView.builder(
            itemCount: articles.length,
            itemBuilder: (context, index) {
              final article = articles[index];
              return ListTile(
                title: Text(article.title),
                subtitle: Text(article.body),
                onTap: () async {
                  // go to update page
                  final updated = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => UpdateArticlePage(article: article),
                    ),
                  );

                  if (updated != null) {
                    _refreshArticles();
                  }
                },
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () async {
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text("Confirm Delete"),
                        content: Text(
                          "Are you sure you want to delete '${article.title}'?",
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(ctx, false),
                            child: const Text("Cancel"),
                          ),
                          ElevatedButton(
                            onPressed: () => Navigator.pop(ctx, true),
                            child: const Text("Delete"),
                          ),
                        ],
                      ),
                    );

                    if (confirm == true) {
                      try {
                        await deleteData(article.aid);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Article deleted successfully"),
                          ),
                        );
                        _refreshArticles();
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Delete failed: $e")),
                        );
                      }
                    }
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final added = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => WriterPage()),
          );
          if (added == true) {
            _refreshArticles();
          }
        },
        child: const Icon(Icons.add),
        tooltip: 'Add Article',
      ),
    );
  }
}
