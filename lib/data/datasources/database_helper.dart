import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('curio.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 3,
      onCreate: _createDB,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';

    await db.execute('''
      CREATE TABLE favorites (
        id $idType,
        articleId $textType,
        articleTitle $textType,
        articleDescription $textType,
        articleUrlImage $textType,
        articleAuthor $textType,
        articlePublishedAt $textType,
        reaction $textType,
        createdAt $textType,
        UNIQUE(articleId)
      )
    ''');

    await db.execute('''
      CREATE TABLE cached_articles (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        description TEXT NOT NULL,
        category TEXT NOT NULL,
        content TEXT NOT NULL,
        urlImage TEXT NOT NULL,
        author TEXT NOT NULL,
        publishedAt TEXT NOT NULL,
        keyword TEXT,
        cachedAt TEXT NOT NULL,
        language TEXT NOT NULL DEFAULT 'en'
      )
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('''
        CREATE TABLE IF NOT EXISTS cached_articles (
          id TEXT PRIMARY KEY,
          title TEXT NOT NULL,
          description TEXT NOT NULL,
          category TEXT NOT NULL,
          content TEXT NOT NULL,
          urlImage TEXT NOT NULL,
          author TEXT NOT NULL,
          publishedAt TEXT NOT NULL,
          keyword TEXT,
          cachedAt TEXT NOT NULL
        )
      ''');
    }
    if (oldVersion < 3) {
      // Ajouter la colonne language à la table cached_articles
      await db.execute('''
        ALTER TABLE cached_articles ADD COLUMN language TEXT NOT NULL DEFAULT 'en'
      ''');
    }
  }

  Future<void> close() async {
    final db = await instance.database;
    db.close();
  }
}
