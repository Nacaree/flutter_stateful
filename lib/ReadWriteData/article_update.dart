
import 'package:flutter/material.dart';
import 'package:learn_stateful/ReadWriteData/article_model.dart';
import 'package:learn_stateful/ReadWriteData/article_service.dart';

class UpdateArticlePage extends StatefulWidget {
  final Article article;

  const UpdateArticlePage({Key? key, required this.article}) : super(key: key);

  @override
  State<UpdateArticlePage> createState() => _ArticleUpdatePageState();
}

class _ArticleUpdatePageState extends State<UpdateArticlePage> {
  late TextEditingController _titleController;
  late TextEditingController _bodyController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.article.title);
    _bodyController = TextEditingController(text: widget.article.body);
  }

  Future<void> _updateArticle() async {
    setState(() => _isLoading = true);

    try {
      Article updated = Article(
        aid: widget.article.aid,
        title: _titleController.text,
        body: _bodyController.text,
      );

      String result = await updateData(updated);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Success: $result")),
      );
      Navigator.pop(context, updated); // return updated article
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Update Article")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: "Title"),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _bodyController,
              maxLines: 5,
              decoration: const InputDecoration(labelText: "Body"),
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _updateArticle,
                    child: const Text("Update"),
                  ),
          ],
        ),
      ),
    );
  }
}