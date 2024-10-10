  import 'package:sqflite/sqflite.dart';
  import 'package:path/path.dart';
  import 'package:webtoon/webtoon.dart';

  class DatabaseHelper {
    static final DatabaseHelper instance = DatabaseHelper._init();
    static Database? _database;

    DatabaseHelper._init();

    Future<Database> get database async {
      if (_database != null) return _database!;
      _database = await _initDB('webtoons.db');
      return _database!;
    }

    Future<Database> _initDB(String filePath) async {
      final dbPath = await getDatabasesPath();
      final path = join(dbPath, filePath);
      return await openDatabase(path, version: 1, onCreate: _createDB);
    }

    Future<void> _createDB(Database db, int version) async {
      await db.execute('''
        CREATE TABLE favorites(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT,
          description TEXT,
          imageUrl TEXT,
          rating REAL
        )
      ''');
    }

    Future<int> insertFavorite(Webtoon webtoon) async {
      final db = await instance.database;
      return await db.insert('favorites', webtoon.toMap());
    }

    Future<int> deleteFavorite(String title) async {
      final db = await instance.database;
      return await db.delete('favorites', where: 'title = ?', whereArgs: [title]);
    }

    Future<List<Webtoon>> getFavorites() async {
      final db = await instance.database;
      final maps = await db.query('favorites');
      return List.generate(maps.length, (i) => Webtoon.fromMap(maps[i]));
    }

    Future<bool> isFavorite(String title) async {
      final db = await instance.database;
      final maps = await db.query('favorites', where: 'title = ?', whereArgs: [title]);
      return maps.isNotEmpty;
    }
  }