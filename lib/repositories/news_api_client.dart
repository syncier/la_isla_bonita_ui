import 'package:la_isla_Bonita_ui/models/models.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NewsApiClient {
  static const baseUrl = 'https://newsapi.org';
  final http.Client httpClient;

  NewsApiClient({
    @required this.httpClient,
  }) : assert(httpClient != null);

  Future<NewsApiResponse> fetchWeather(ArticlesQuery query) async {
    final newsUrl =
        '$baseUrl/v2/everything' + query.getParams();
    final newsResponse = await this.httpClient.get(newsUrl);

    if (newsResponse.statusCode != 200) {
      throw Exception('error getting news');
    }

    final newsJson = jsonDecode(newsResponse.body);
    return NewsApiResponse.fromJson(newsJson);
  }
}