import 'package:curio/data/datasources/article_remote_datasource.dart';
import 'package:curio/domain/entities/article.dart';
import 'package:curio/domain/repositories/article_repository.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final ArticleRemoteDataSource remoteArticleDataSource;

  ArticleRepositoryImpl(this.remoteArticleDataSource);

  @override
  Future<List<Article>> getArticles() async {
    try {
      // Fetch articles from the remote source
      final articles = await remoteArticleDataSource.fetchArticles();

      // Convert ArticleModels to Entities
      return articles.map((model) => Article(
        id: model.id,
        title: model.title,
        description: model.description,
        category: model.category,
        content: model.content,
        urlImage: model.urlImage,
      )).toList();
    } catch (e) {
      // Handle errors appropriately
      throw Exception('Failed to fetch articles: $e');
    }
  }

  @override
  Future<void> clearHistory() {
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