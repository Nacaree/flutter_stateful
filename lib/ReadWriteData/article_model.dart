import 'dart:convert';

ArticleModel articleModelFromMap(String str) =>
    ArticleModel.fromMap(json.decode(str));

String articleModelToMap(ArticleModel data) => json.encode(data.toMap());

class ArticleModel {
  ArticleModel({this.articles = const []});

  List<Article> articles;

  factory ArticleModel.fromMap(Map<String, dynamic> json) => ArticleModel(
    articles: List<Article>.from(
      json["articles"].map((x) => Article.fromMap(x)),
    ),
  );

  Map<String, dynamic> toMap() => {
    "articles": List<dynamic>.from(articles.map((x) => x.toMap())),
  };
}

class Article {
  Article({
    this.aid = "0",
    this.title = "no title",
    this.body = "no body",
    this.date = "no date",
  });

  String aid;
  String title;
  String body;
  String date;

  factory Article.fromMap(Map<String, dynamic> json) => Article(
    aid: json["aid"] ?? "0",
    title: json["title"] ?? "no title",
    body: json["body"] ?? "no body",
    date: json["created_at"] ?? "no date",
  );

  // Use this for sending to backend (creation)
  Map<String, dynamic> toCreateMap() => {
    "title": title,
    "body": body,
    "created_at": date,
    // If your backend expects "created_at" or "date", add it here
    // "created_at": date,
  };

  // Use this for reading/writing full objects
  Map<String, dynamic> toMap() => {
    "aid": aid,
    "title": title,
    "body": body,
    "date": date,
  };
}
