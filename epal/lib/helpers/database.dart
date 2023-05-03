import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const String dbName = 'my_database.db';
  static const String tableUser = 'user';
  static const String columnUserRole = 'user_role';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName);

    return openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableUser (
        $columnUserRole TEXT PRIMARY KEY
      )
    ''');
  }

  Future<void> saveUserRole(String userRole) async {
    final db = await database;
    await db.insert(tableUser, {columnUserRole: userRole},
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<String?> getUserRole() async {
    final db = await database;
    final results = await db.query(tableUser, limit: 1);

    if (results.isEmpty) {
      return null;
    }

    return results.first[columnUserRole] as String?;
  }
}
