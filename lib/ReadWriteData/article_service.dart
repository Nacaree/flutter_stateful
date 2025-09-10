import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:learn_stateful/ReadWriteData/article_model.dart';

Future<ArticleModel> getArticles() async {
  // * Fixed 404 error, i.e (it was caused by a typo, 'api4fllutter')
  String url = "http://192.168.1.98/api4flutter/read.php";
  http.Response response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    return compute(articleModelFromMap, response.body);
  } else {
    throw Exception("Error while reading: ${response.statusCode}");
  }
}
