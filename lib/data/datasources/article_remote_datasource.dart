import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:curio/config/logger.dart';

abstract class ArticleRemoteDataSource {
  Future<List<dynamic>> fetchArticles(String languageCode);
  Future<List<dynamic>> fetchArticlesByKeyword(
    String keyword,
    String languageCode,
  );
}

class ArticleRemoteDataSourceImpl implements ArticleRemoteDataSource {
  final http.Client client;

  ArticleRemoteDataSourceImpl(this.client);

  @override
  Future<List<dynamic>> fetchArticles(String languageCode) async {
    final response = await client.get(
      Uri.parse(
        'https://gnews.io/api/v4/top-headlines?&lang=$languageCode&apikey=${dotenv.env['GNEWS_API_TOKEN']}',
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
  Future<List<dynamic>> fetchArticlesByKeyword(
    String keyword,
    String languageCode,
  ) async {
    AppLogger.debug('Fetching articles for keyword: $keyword');
    final encodedUri = Uri.encodeComponent(keyword.trim());
    final uri = Uri.parse(
      'https://gnews.io/api/v4/search?q=$encodedUri&lang=$languageCode&apikey=${dotenv.env['GNEWS_API_TOKEN']}',
    );
    final response = await client.get(uri);
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<dynamic> articlesJson = data['articles'] ?? [];
      return articlesJson;
    } else {
      return [];
    }
  }
}
