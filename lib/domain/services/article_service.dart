import '../entities/article.dart';
import '../repositories/article_repository.dart';

class ArticleService {
  final ArticleRepository _repository;

  ArticleService(this._repository);

  Future<Article?> getArticle(String id) async {
    return await _repository.getArticle(id);
  }

  Future<List<Article>> getArticles() async {
    return await _repository.getArticles();
  }

  Future<List<Article>> getArticlesByKeyword(String keyword) async {
    return await _repository.getArticlesByKeyword(keyword);
  }

  Future<void> clearArticles() async {
    await _repository.clearArticles();
  }
}
