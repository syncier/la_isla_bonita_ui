import 'dart:async';

import 'package:la_isla_Bonita_ui/models/models.dart';
import 'package:la_isla_Bonita_ui/repositories/news_api_client.dart';
import 'package:meta/meta.dart';


class NewsRepository {
  final NewsApiClient newsApiClient;

  NewsRepository({@required this.newsApiClient})
      : assert(newsApiClient != null);

  Future<NewsApiResponse> getNews(ArticlesQuery query) async {
    return newsApiClient.fetchNews(query);
  }
}