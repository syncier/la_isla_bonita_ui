import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:la_isla_Bonita_ui/models/models.dart';
import 'package:meta/meta.dart';

class NewsApiClient {
  static const baseUrl = 'https://news.isla-bonita.marketplace.syncier.com/';
  final http.Client httpClient;

  NewsApiClient({
    @required this.httpClient,
  }) : assert(httpClient != null);

  Future<NewsApiResponse> fetchNews(ArticlesQuery query) async {
    final newsUrl =
        '$baseUrl/rss/';
    final newsResponse = await this.httpClient.get(Uri.parse(newsUrl));


    if (newsResponse.statusCode != 200) {
      throw Exception('error getting news');
    }

    final newsJson = jsonDecode(newsResponse.body);
    return NewsApiResponse.fromJson(newsJson);
  }
}
