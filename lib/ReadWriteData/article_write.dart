import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:learn_stateful/ReadWriteData/article_model.dart';
import 'package:learn_stateful/ReadWriteData/article_service.dart';

class WriterPage extends StatefulWidget {
  const WriterPage({super.key});

  @override
  _WriterPageState createState() => _WriterPageState();
}

// class _WriterPageState extends State<WriterPage> {
//   final _titleCtrl = TextEditingController();
//   final _bodyCtrl = TextEditingController();
//
//   Widget _buildBody() {
//     return Container(
//       padding: EdgeInsets.all(20),
//       alignment: Alignment.center,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           TextField(
//             controller: _titleCtrl,
//             decoration: InputDecoration(labelText: "Title"),
//           ), // TextField
//           TextField(
//             controller: _bodyCtrl,
//             decoration: InputDecoration(labelText: "Body"),
//           ), // TextField
//           SizedBox(height: 10),
//           ElevatedButton(
//             child: Text("Add"),
//             onPressed: () {
//               String titleText = _titleCtrl.text;
//               String bodyText = _bodyCtrl.text;
//               Article article = Article(
//                 title: titleText,
//                 body: bodyText,
//               ); // Article
//               Map<String, dynamic> articleMap = article.toCreateMap();
//               String jsonBody = json.encode(articleMap);
//               insertData(article)
//                   .then((value) {
//                     print("SUCCESS: Server responded with: $value");
//                   })
//                   .catchError((error) {
//                     print("FAILURE: Request failed with error: $error");
//                   });
//             },
//           ), // ElevatedButton
//         ], // <Widget>[]
//       ), // Column
//     ); // Container
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Write Page"),
//         backgroundColor: Colors.pink,
//       ), // AppBar
//       body: _buildBody(),
//     ); // Scaffold
//   }
// }

class _WriterPageState extends State<WriterPage> {
  final _titleCtrl = TextEditingController();
  final _bodyCtrl = TextEditingController();
  bool _isLoading = false;

  Future<void> _addArticle() async {
    if (_titleCtrl.text.isEmpty || _bodyCtrl.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Title and body cannot be empty.")),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      Article article = Article(
        title: _titleCtrl.text,
        body: _bodyCtrl.text,
      );
      final result = await insertData(article);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Article added: $result")),
      );
      Navigator.pop(context, true);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to add article: $e")),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Write Page"),
        backgroundColor: Colors.pink,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _titleCtrl,
              decoration: const InputDecoration(labelText: "Title"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _bodyCtrl,
              decoration: const InputDecoration(labelText: "Body"),
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _addArticle,
                    child: const Text("Add"),
                  ),
          ],
        ),
      ),
    );
  }
}
