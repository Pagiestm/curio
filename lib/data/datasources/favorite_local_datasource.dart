import 'package:curio/data/datasources/database_helper.dart';
import 'package:curio/domain/entities/favorite.dart';
import 'package:sqflite/sqflite.dart';

abstract class FavoriteLocalDataSource {
  Future<List<Favorite>> getAllFavorites();
  Future<Favorite?> getFavoriteByArticleId(String articleId);
  Future<List<Favorite>> getFavoritesByReaction(ReactionType reaction);
  Future<int> createFavorite(Favorite favorite);
  Future<int> updateFavorite(Favorite favorite);
  Future<int> deleteFavorite(int id);
  Future<int> deleteFavoriteByArticleId(String articleId);
  Future<bool> isFavorite(String articleId);
}

class FavoriteLocalDataSourceImpl implements FavoriteLocalDataSource {
  final DatabaseHelper _databaseHelper;

  FavoriteLocalDataSourceImpl(this._databaseHelper);

  static const String _tableName = 'favorites';

  @override
  Future<List<Favorite>> getAllFavorites() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      orderBy: 'createdAt DESC',
    );

    return List.generate(maps.length, (i) {
      return Favorite.fromMap(maps[i]);
    });
  }

  @override
  Future<Favorite?> getFavoriteByArticleId(String articleId) async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'articleId = ?',
      whereArgs: [articleId],
    );

    if (maps.isEmpty) return null;
    return Favorite.fromMap(maps.first);
  }

  @override
  Future<List<Favorite>> getFavoritesByReaction(ReactionType reaction) async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'reaction = ?',
      whereArgs: [reaction.value],
      orderBy: 'createdAt DESC',
    );

    return List.generate(maps.length, (i) {
      return Favorite.fromMap(maps[i]);
    });
  }

  @override
  Future<int> createFavorite(Favorite favorite) async {
    final db = await _databaseHelper.database;
    return await db.insert(
      _tableName,
      favorite.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<int> updateFavorite(Favorite favorite) async {
    final db = await _databaseHelper.database;
    return await db.update(
      _tableName,
      favorite.toMap(),
      where: 'id = ?',
      whereArgs: [favorite.id],
    );
  }

  @override
  Future<int> deleteFavorite(int id) async {
    final db = await _databaseHelper.database;
    return await db.delete(_tableName, where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<int> deleteFavoriteByArticleId(String articleId) async {
    final db = await _databaseHelper.database;
    return await db.delete(
      _tableName,
      where: 'articleId = ?',
      whereArgs: [articleId],
    );
  }

  @override
  Future<bool> isFavorite(String articleId) async {
    final favorite = await getFavoriteByArticleId(articleId);
    return favorite != null;
  }
}
