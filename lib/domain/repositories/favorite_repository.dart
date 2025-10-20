import 'package:curio/domain/entities/favorite.dart';

abstract class FavoriteRepository {
  Future<List<Favorite>> getAllFavorites();
  Future<Favorite?> getFavoriteByArticleId(String articleId);
  Future<List<Favorite>> getFavoritesByReaction(ReactionType reaction);
  Future<int> addFavorite(Favorite favorite);
  Future<int> updateFavorite(Favorite favorite);
  Future<int> removeFavorite(int id);
  Future<int> removeFavoriteByArticleId(String articleId);
  Future<bool> isFavorite(String articleId);
}
