import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'model/JokeModel.dart';

Future<JokeModel> fetchJoke() async {
  String url = "https://official-joke-api.appspot.com/random_joke";

  final response = await http.get(
    Uri.parse(url),
    headers: {'User-Agent': 'Dart HTTP Client', "Accept": "application/json"},
  );
  if (response.statusCode == 200) {
    return compute(parseJoke, response.body);
  } else if (response.statusCode == 429) {
    // * I Spammed this too many times and it broke 429 error(too many requests)
    await Future.delayed(const Duration(seconds: 10));
  }
  throw Exception("Failed to load joke. Code: ${response.statusCode}");
}

JokeModel parseJoke(String responseBody) {
  final Map<String, dynamic> jsonMap = json.decode(responseBody);
  return JokeModel.fromJson(jsonMap);
}
