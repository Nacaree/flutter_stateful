import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:learn_stateful/ReadWriteData/article_model.dart';

Future<ArticleModel> getArticles() async {
  // * Fixed 404 error, i.e (it was caused by a typo, 'api4fllutter')
  String url = "http://172.20.10.9/api4flutter/read.php";
  // String url = "http://192.168.1.98/api4flutter/read.php";
  http.Response response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    return compute(articleModelFromMap, response.body);
  } else {
    throw Exception("Error while reading: ${response.statusCode}");
  }
}

Future<String> insertData(Article article) async {
  String url = "http://172.20.10.9/api4flutter/write.php";
  final body = json.encode(article.toCreateMap());
  // String url = "http://192.168.1.98/api4fllutter/write.php";
  http.Response response = await http.post(Uri.parse(url), body: body);
  if (response.statusCode == 200) {
    return response.body;
  } else {}
  throw Exception("Error while writing: ${response.statusCode}");
}

Future<String> updateData(Article article) async {
  String url = "http://172.20.10.9/api4flutter/update.php";
  final body = json.encode(article.toUpdateMap());

  print("Sending to $url -> $body");

  http.Response response = await http.put(
    Uri.parse(url),
    headers: {"Content-Type": "application/json"},
    body: body,
  );

  print("Response [${response.statusCode}] -> ${response.body}");

  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception(
      "Error while updating: ${response.statusCode}, Body: ${response.body}",
    );
  }
}

Future<String> deleteData(String aid) async {
  String url = "http://172.20.10.9/api4flutter/delete.php";
  final body = json.encode({"aid": aid});

  print("Sending DELETE to $url -> $body");

  final request = http.Request("DELETE", Uri.parse(url))
    ..headers["Content-Type"] = "application/json"
    ..body = body;

  final response = await request.send();
  final responseBody = await response.stream.bytesToString();

  print("Response [${response.statusCode}] -> $responseBody");

  if (response.statusCode == 200) {
    return responseBody;
  } else {
    throw Exception(
      "Error while deleting: ${response.statusCode}, Body: $responseBody",
    );
  }
}
