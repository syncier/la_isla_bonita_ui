import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class NewsApiResponse {
  final List<Article> articles;
  final String error;

  NewsApiResponse(this.articles, this.error);

  NewsApiResponse.fromJson(Map<String, dynamic> json)
      : articles =
            (json["content"] as List).map((i) => Article.fromJson(i)).toList(),
        error = "";

  NewsApiResponse.withError(String errorValue)
      : articles = [],
        error = errorValue;
}

class Article extends Equatable {
  final num id;
  final String title;
  final String description;
  final String imageURL;
  final String content;
  final String sourceURL;

  const Article(this.title, this.id, this.description, this.imageURL,
      this.content, this.sourceURL);

  Article.fromJson(Map<String, dynamic> json)
      : title = json["title"],
        id = json["id"],
        description = json["description"],
        imageURL = json["imageURL"],
        content = json["content"],
        sourceURL = json["sourceURL"];

  @override
  List<Object> get props => [
        title,
        id,
        description,
        imageURL,
        content,
        sourceURL,
      ];
}

class ArticleSource {
  final String id;
  final String name;

  ArticleSource(this.id, this.name);

  ArticleSource.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"];
}

class ArticlesQuery {
  final String query;
  final int pageSize;
  final int page;
  final String sortBy;
  final String apiKey = 'c2e3519af2344568a5174722e4ec1997';

  ArticlesQuery.buildQuery(
      {@required this.query,
      this.pageSize = 5,
      this.page = 1,
      this.sortBy = 'relevancy'});

  String getParams() {
    return '?q=$query&pageSize=$pageSize&page=$page&sortBy=$sortBy&apiKey=$apiKey';
  }
}
