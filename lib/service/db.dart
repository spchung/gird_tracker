import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  Database? _database;

  // Initialize the database (called once by GetIt, ensures lazy loading)
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Create or open the database
  Future<Database> _initDatabase() async {
    String path = await getDatabasesPath();
    String dbPath = join(path, 'db.db');
    print('Database path: $dbPath');
    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      -- logged workout sessiongs
      CREATE TABLE sessions(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        workout_group_id INTEGER,
        datetime TEXT,
        exercises TEXT
      );
      '''
    );
    await db.execute(
      '''
      -- arbitrary grouping of workouts
      CREATE TABLE workout_groups(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name VARCHAR,
        description TEXT
      );
      '''
    );
    await db.execute(
    '''
      -- exetcise, arbitrary name, description, and grouping
      CREATE TABLE exercises(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name VARCHAR,
        description TEXT,
        workout_group_id INTEGER
      );
    ''');
  }

  Future<void> initDatabase() async {
    await _initDatabase();
  }
}