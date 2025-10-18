import 'package:curio/domain/entities/article.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

abstract class ArticleRemoteDataSource {
  Future<List<Article>> fetchArticles();
}

class ArticleRemoteDataSourceImpl implements ArticleRemoteDataSource {
  final http.Client client;

  ArticleRemoteDataSourceImpl(this.client);

  @override
  Future<List<Article>> fetchArticles() async {
    final response = await client.get(
      Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=us&apiKey=${dotenv.env['NEWS_API_TOKEN']}',
      ),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<dynamic> articlesJson = data['articles'] ?? [];
      return articlesJson.map((raw) {
        final json = {
          'id': raw['url'],
          'title': raw['title'],
          'description': raw['description'],
          'category': raw['source']['name'],
          'content': raw['content'],
          'urlImage': raw['urlToImage'],
          'author': raw['author'],
          'publishedAt': raw['publishedAt'],
        };
        return Article.fromJson(json);
      }).toList();
    } else {
      throw Exception('Failed to load articles');
    }
  }
}
