import 'package:curio/config/logger.dart';
import 'package:curio/data/datasources/article_local_datasource.dart';
import 'package:curio/data/datasources/article_remote_datasource.dart';
import 'package:curio/domain/entities/article.dart';
import 'package:curio/domain/repositories/article_repository.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final ArticleRemoteDataSource remoteArticleDataSource;
  final ArticleLocalDataSource localArticleDataSource;

  final int cacheValidityDuration;

  ArticleRepositoryImpl(
    this.remoteArticleDataSource,
    this.localArticleDataSource, {
    this.cacheValidityDuration = 30, // 30 minutes par défaut
  });

  bool _isCacheValid(DateTime? lastCacheTime) {
    if (lastCacheTime == null) return false;

    final now = DateTime.now();
    final difference = now.difference(lastCacheTime);

    return difference.inMinutes < cacheValidityDuration;
  }

  @override
  Future<List<Article>> getArticles() async {
    try {
      // Vérifier le cache d'abord
      final lastCacheTime = await localArticleDataSource.getLastCacheTime();

      if (_isCacheValid(lastCacheTime)) {
        AppLogger.info('Using cached articles');
        final cachedArticles = await localArticleDataSource.getCachedArticles();

        if (cachedArticles.isNotEmpty) {
          return cachedArticles;
        }
      }

      // Si le cache est invalide ou vide, faire un appel API
      AppLogger.info('Fetching fresh articles from API');
      final articlesRaw = await remoteArticleDataSource.fetchArticles();

      final articles = articlesRaw.map((raw) {
        final json = {
          'id': raw['url'],
          'title': raw['title'],
          'description': raw['description'],
          'category': raw['source']['name'],
          'content': raw['content'],
          'urlImage': raw['urlToImage'],
          'author': raw['author'] ?? '',
          'publishedAt': raw['publishedAt'] ?? DateTime.now().toIso8601String(),
        };
        return Article.fromJson(json);
      }).toList();

      // Met en cache les nouveaux articles
      await localArticleDataSource.cacheArticles(articles);

      return articles;
    } catch (e) {
      // En cas d'erreur API, essayer de retourner le cache même expiré
      AppLogger.error('Error fetching articles', e);
      final cachedArticles = await localArticleDataSource.getCachedArticles();

      if (cachedArticles.isNotEmpty) {
        AppLogger.info('Returning expired cache due to API error');
        return cachedArticles;
      }

      throw Exception('Failed to fetch articles: $e');
    }
  }

  @override
  Future<List<Article>> getArticlesByKeyword(String keyword) async {
    try {
      final lastCacheTime = await localArticleDataSource
          .getLastCacheTimeForKeyword(keyword);

      if (_isCacheValid(lastCacheTime)) {
        AppLogger.info('Using cached articles for keyword: $keyword');
        final cachedArticles = await localArticleDataSource
            .getCachedArticlesByKeyword(keyword);

        if (cachedArticles.isNotEmpty) {
          return cachedArticles;
        }
      }

      AppLogger.info('Fetching fresh articles from API for keyword: $keyword');
      final articlesRaw = await remoteArticleDataSource.fetchArticlesByKeyword(
        keyword,
      );

      final articles = articlesRaw.map((raw) {
        final json = {
          'id': raw['url'],
          'title': raw['title'],
          'description': raw['description'],
          'category': raw['source']['name'],
          'content': raw['content'],
          'urlImage': raw['urlToImage'],
          'author': raw['author'] ?? '',
          'publishedAt': raw['publishedAt'] ?? DateTime.now().toIso8601String(),
        };
        return Article.fromJson(json);
      }).toList();

      // Mettre en cache les nouveaux articles pour ce keyword
      await localArticleDataSource.cacheArticlesForKeyword(keyword, articles);

      return articles;
    } catch (e) {
      // En cas d'erreur API, essayer de retourner le cache même expiré
      AppLogger.error('Error fetching articles by keyword', e);
      final cachedArticles = await localArticleDataSource
          .getCachedArticlesByKeyword(keyword);

      if (cachedArticles.isNotEmpty) {
        AppLogger.info('Returning expired cache due to API error');
        return cachedArticles;
      }

      throw Exception('Failed to fetch articles by keyword: $e');
    }
  }

  @override
  Future<void> clearArticles() async {
    await localArticleDataSource.clearCache();
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
