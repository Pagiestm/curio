import 'package:curio/data/datasources/article_remote_datasource.dart';
import 'package:curio/domain/entities/article.dart';
import 'package:curio/domain/repositories/article_repository.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final ArticleRemoteDataSource remoteArticleDataSource;

  ArticleRepositoryImpl(this.remoteArticleDataSource);

  @override
  Future<List<Article>> getArticles() async {
    try {
      final articlesRaw = await remoteArticleDataSource.fetchArticles();

      return articlesRaw.map((raw) {
        final json = {
          'id': raw['url'],
          'title': raw['title'],
          'description': raw['description'],
          'category': raw['source']['name'],
          'content': raw['content'],
          'urlImage': raw['urlToImage'],
        };
        return Article.fromJson(json);
      }).toList();
    } catch (e) {
      throw Exception('Failed to fetch articles: $e');
    }
  }

  @override
  Future<List<Article>> getArticlesByKeyword(String keyword) async {
    try {
      final articlesRaw = await remoteArticleDataSource.fetchArticlesByKeyword(
        keyword,
      );

      return articlesRaw.map((raw) {
        final json = {
          'id': raw['url'],
          'title': raw['title'],
          'description': raw['description'],
          'category': raw['source']['name'],
          'content': raw['content'],
          'urlImage': raw['urlToImage'],
        };
        return Article.fromJson(json);
      }).toList();
    } catch (e) {
      throw Exception('Failed to fetch articles by keyword: $e');
    }
  }

  @override
  Future<void> clearArticles() {
    // TODO: implement clearHistory
    throw UnimplementedError();
  }

  @override
  Future<Article?> getArticle(String id) {
    // TODO: implement getArticle
    throw UnimplementedError();
  }

  Future<List<Article>> getArticleHistory() {
    // TODO: implement getArticleHistory
    throw UnimplementedError();
  }
}
