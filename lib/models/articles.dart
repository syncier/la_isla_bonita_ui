import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class NewsApiResponse {
  final List<Article> articles;
  final String error;

  NewsApiResponse(this.articles, this.error);

  NewsApiResponse.fromJson(Map<String, dynamic> json)
      : articles = (json["articles"] as List)
            .map((i) => new Article.fromJson(i))
            .toList(),
        error = "";

  NewsApiResponse.withError(String errorValue)
      : articles = List(),
        error = errorValue;
}

class Article extends Equatable {
  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String content;
  final ArticleSource source;

  const Article(this.author, this.title, this.description, this.url,
      this.urlToImage, this.content, this.source);

  Article.fromJson(Map<String, dynamic> json)
      : author = json["author"],
        title = json["title"],
        description = json["description"],
        url = json["url"],
        urlToImage = json["urlToImage"],
        content = json["content"],
        source = ArticleSource.fromJson(json["source"]);

  @override
  List<Object> get props => [
        author,
        title,
        description,
        url,
        urlToImage,
        content,
        source,
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
