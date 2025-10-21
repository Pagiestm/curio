import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:curio/config/logger.dart';

abstract class ArticleRemoteDataSource {
  Future<List<dynamic>> fetchArticles();
  Future<List<dynamic>> fetchArticlesByKeyword(String keyword);
}

class ArticleRemoteDataSourceImpl implements ArticleRemoteDataSource {
  final http.Client client;

  ArticleRemoteDataSourceImpl(this.client);

  @override
  Future<List<dynamic>> fetchArticles() async {
    final response = await client.get(
      Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=us&apiKey=${dotenv.env['NEWS_API_TOKEN']}',
      ),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return data['articles'] ?? [];
    } else {
      throw Exception('Failed to load articles');
    }
  }

  @override
  Future<List<dynamic>> fetchArticlesByKeyword(String keyword) async {
    AppLogger.debug('Fetching articles for keyword: $keyword');
    final response = await client.get(
      Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=us&q=$keyword&apiKey=${dotenv.env['NEWS_API_TOKEN']}',
      ),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<dynamic> articlesJson = data['articles'] ?? [];
      return articlesJson;
    } else {
      throw Exception('Failed to load articles by keyword');
    }
  }
}
