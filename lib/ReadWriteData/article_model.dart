import 'dart:convert';

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
    date: json["date"] ?? "no date",
  );

  get articles => null;

  Map<String, dynamic> toCreateMap() => {"title": title, "body": body};
  Map<String, dynamic> toMap() => {
    "aid": aid,
    "title": title,
    "body": body,
    "date": date,
  };

  Map<String, dynamic> toUpdateMap() {
    return {"aid": aid, "title": title, "body": body};
  }
}

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
