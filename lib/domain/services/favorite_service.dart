import 'package:curio/domain/entities/article.dart';
import 'package:curio/domain/entities/favorite.dart';
import 'package:curio/domain/repositories/favorite_repository.dart';

class FavoriteService {
  final FavoriteRepository _repository;

  FavoriteService(this._repository);

  Future<List<Favorite>> getAllFavorites() async {
    return await _repository.getAllFavorites();
  }

  Future<Favorite?> getFavoriteByArticleId(String articleId) async {
    return await _repository.getFavoriteByArticleId(articleId);
  }

  Future<List<Favorite>> getFavoritesByReaction(ReactionType reaction) async {
    return await _repository.getFavoritesByReaction(reaction);
  }

  Future<int> addFavorite(Article article, ReactionType reaction) async {
    final favorite = Favorite(
      articleId: article.id,
      articleTitle: article.title,
      articleDescription: article.description,
      articleUrlImage: article.urlImage,
      articleAuthor: article.author,
      articlePublishedAt: article.publishedAt,
      reaction: reaction,
      createdAt: DateTime.now(),
    );

    return await _repository.addFavorite(favorite);
  }

  Future<int> updateFavoriteReaction(
    Favorite favorite,
    ReactionType newReaction,
  ) async {
    final updatedFavorite = favorite.copyWith(reaction: newReaction);
    return await _repository.updateFavorite(updatedFavorite);
  }

  Future<int> removeFavorite(int id) async {
    return await _repository.removeFavorite(id);
  }

  Future<int> removeFavoriteByArticleId(String articleId) async {
    return await _repository.removeFavoriteByArticleId(articleId);
  }

  Future<bool> isFavorite(String articleId) async {
    return await _repository.isFavorite(articleId);
  }

  Future<void> toggleFavorite(Article article, ReactionType reaction) async {
    final isFav = await isFavorite(article.id);
    if (isFav) {
      await removeFavoriteByArticleId(article.id);
    } else {
      await addFavorite(article, reaction);
    }
  }
}
