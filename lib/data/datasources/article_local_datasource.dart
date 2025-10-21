import 'package:curio/data/datasources/database_helper.dart';
import 'package:curio/domain/entities/article.dart';
import 'package:sqflite/sqflite.dart';

abstract class ArticleLocalDataSource {
  Future<List<Article>> getCachedArticles();
  Future<List<Article>> getCachedArticlesByKeyword(String keyword);
  Future<void> cacheArticles(List<Article> articles);
  Future<void> cacheArticlesForKeyword(String keyword, List<Article> articles);
  Future<DateTime?> getLastCacheTime();
  Future<DateTime?> getLastCacheTimeForKeyword(String keyword);
  Future<void> clearCache();
  Future<void> clearCacheForKeyword(String keyword);
}

class ArticleLocalDataSourceImpl implements ArticleLocalDataSource {
  final DatabaseHelper databaseHelper;

  ArticleLocalDataSourceImpl(this.databaseHelper);

  @override
  Future<List<Article>> getCachedArticles() async {
    final db = await databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'cached_articles',
      where: 'keyword IS NULL OR keyword = ?',
      whereArgs: [''],
      orderBy: 'publishedAt DESC',
    );

    return maps.map((map) => Article.fromJson(map)).toList();
  }

  @override
  Future<List<Article>> getCachedArticlesByKeyword(String keyword) async {
    final db = await databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'cached_articles',
      where: 'keyword = ?',
      whereArgs: [keyword],
      orderBy: 'publishedAt DESC',
    );

    return maps.map((map) => Article.fromJson(map)).toList();
  }

  @override
  Future<void> cacheArticles(List<Article> articles) async {
    final db = await databaseHelper.database;
    final batch = db.batch();

    // Supprime les anciens articles en cache
    batch.delete(
      'cached_articles',
      where: 'keyword IS NULL OR keyword = ?',
      whereArgs: [''],
    );

    final now = DateTime.now().toIso8601String();
    for (var article in articles) {
      batch.insert(
        'cached_articles',
        {
          ...article.toJson(),
          'keyword': '',
          'cachedAt': now,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    await batch.commit(noResult: true);
  }

  @override
  Future<void> cacheArticlesForKeyword(
    String keyword,
    List<Article> articles,
  ) async {
    final db = await databaseHelper.database;
    final batch = db.batch();

    batch.delete(
      'cached_articles',
      where: 'keyword = ?',
      whereArgs: [keyword],
    );

    final now = DateTime.now().toIso8601String();
    for (var article in articles) {
      batch.insert(
        'cached_articles',
        {
          ...article.toJson(),
          'keyword': keyword,
          'cachedAt': now,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    await batch.commit(noResult: true);
  }

  @override
  Future<DateTime?> getLastCacheTime() async {
    final db = await databaseHelper.database;
    final List<Map<String, dynamic>> result = await db.query(
      'cached_articles',
      columns: ['cachedAt'],
      where: 'keyword IS NULL OR keyword = ?',
      whereArgs: [''],
      orderBy: 'cachedAt DESC',
      limit: 1,
    );

    if (result.isEmpty) return null;

    return DateTime.tryParse(result.first['cachedAt'] as String);
  }

  @override
  Future<DateTime?> getLastCacheTimeForKeyword(String keyword) async {
    final db = await databaseHelper.database;
    final List<Map<String, dynamic>> result = await db.query(
      'cached_articles',
      columns: ['cachedAt'],
      where: 'keyword = ?',
      whereArgs: [keyword],
      orderBy: 'cachedAt DESC',
      limit: 1,
    );

    if (result.isEmpty) return null;

    return DateTime.tryParse(result.first['cachedAt'] as String);
  }

  @override
  Future<void> clearCache() async {
    final db = await databaseHelper.database;
    await db.delete('cached_articles');
  }

  @override
  Future<void> clearCacheForKeyword(String keyword) async {
    final db = await databaseHelper.database;
    await db.delete(
      'cached_articles',
      where: 'keyword = ?',
      whereArgs: [keyword],
    );
  }
}
