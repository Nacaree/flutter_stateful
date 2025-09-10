import 'package:flutter/material.dart';
import 'package:learn_stateful/ReadWriteData/article_model.dart';
import 'package:learn_stateful/ReadWriteData/article_service.dart';

class ArticlePage extends StatefulWidget {
  const ArticlePage({super.key});

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  late Future<ArticleModel> FutureArticles;

  @override
  void initState() {
    super.initState();
    FutureArticles = getArticles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Articles")),
      body: FutureBuilder<ArticleModel>(
        future: FutureArticles,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.articles.isEmpty) {
            return const Center(child: Text("No Articles"));
          }
          return ListView.builder(
            itemCount: snapshot.data!.articles.length,
            itemBuilder: (context, index) {
              final article = snapshot.data!.articles[index];
              return ListTile(
                title: Text(article.title),
                subtitle: Text(article.body),
                trailing: Text(article.date),
              );
            },
          );
        },
      ),
    );
  }
}
