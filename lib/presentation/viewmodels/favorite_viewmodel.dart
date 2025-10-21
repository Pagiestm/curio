import 'package:curio/config/logger.dart';
import 'package:curio/domain/entities/article.dart';
import 'package:curio/domain/entities/favorite.dart';
import 'package:curio/domain/services/favorite_service.dart';
import 'package:flutter/material.dart';

class FavoriteViewmodel extends ChangeNotifier {
  final FavoriteService _favoriteService;

  FavoriteViewmodel(this._favoriteService);

  List<Favorite> _favorites = [];
  bool _loading = false;
  String? _error;
  ReactionType? _filterReaction;

  List<Favorite> get favorites => _favorites;
  bool get loading => _loading;
  String? get error => _error;
  ReactionType? get filterReaction => _filterReaction;

  Future<void> loadFavorites() async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      if (_filterReaction != null) {
        _favorites = await _favoriteService.getFavoritesByReaction(
          _filterReaction!,
        );
      } else {
        _favorites = await _favoriteService.getAllFavorites();
      }
      _error = null;
    } catch (e) {
      _error = e.toString();
      _favorites = [];
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> addFavorite(Article article, ReactionType reaction) async {
    try {
      await _favoriteService.addFavorite(article, reaction);
      await loadFavorites();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> updateFavoriteReaction(
    Favorite favorite,
    ReactionType newReaction,
  ) async {
    try {
      await _favoriteService.updateFavoriteReaction(favorite, newReaction);
      await loadFavorites();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> removeFavorite(int id) async {
    try {
      await _favoriteService.removeFavorite(id);
      await loadFavorites();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> removeFavoriteByArticleId(String articleId) async {
    try {
      await _favoriteService.removeFavoriteByArticleId(articleId);
      await loadFavorites();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<bool> isFavorite(String articleId) async {
    AppLogger.debug("Checking if favorite: $articleId");
    final t = await _favoriteService.isFavorite(articleId);
    AppLogger.debug("Is favorite: $t");
    return t;
  }

  Future<void> toggleFavorite(Article article, ReactionType reaction) async {
    try {
      await _favoriteService.toggleFavorite(article, reaction);
      await loadFavorites();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  void setFilterReaction(ReactionType? reaction) {
    _filterReaction = reaction;
    loadFavorites();
  }

  void clearFilter() {
    _filterReaction = null;
    loadFavorites();
  }
}
