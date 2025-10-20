import 'package:curio/data/datasources/favorite_local_datasource.dart';
import 'package:curio/domain/entities/favorite.dart';
import 'package:curio/domain/repositories/favorite_repository.dart';

class FavoriteRepositoryImpl implements FavoriteRepository {
  final FavoriteLocalDataSource _localDataSource;

  FavoriteRepositoryImpl(this._localDataSource);

  @override
  Future<List<Favorite>> getAllFavorites() async {
    return await _localDataSource.getAllFavorites();
  }

  @override
  Future<Favorite?> getFavoriteByArticleId(String articleId) async {
    return await _localDataSource.getFavoriteByArticleId(articleId);
  }

  @override
  Future<List<Favorite>> getFavoritesByReaction(ReactionType reaction) async {
    return await _localDataSource.getFavoritesByReaction(reaction);
  }

  @override
  Future<int> addFavorite(Favorite favorite) async {
    return await _localDataSource.createFavorite(favorite);
  }

  @override
  Future<int> updateFavorite(Favorite favorite) async {
    return await _localDataSource.updateFavorite(favorite);
  }

  @override
  Future<int> removeFavorite(int id) async {
    return await _localDataSource.deleteFavorite(id);
  }

  @override
  Future<int> removeFavoriteByArticleId(String articleId) async {
    return await _localDataSource.deleteFavoriteByArticleId(articleId);
  }

  @override
  Future<bool> isFavorite(String articleId) async {
    return await _localDataSource.isFavorite(articleId);
  }
}
