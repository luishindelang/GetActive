import 'package:getactive/DB/Sqlite/Tables/t_activity.dart';
import 'package:getactive/DB/Sqlite/Tables/t_activity_done.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqlConnection {
  static Database? _db;
  static final SqlConnection instance = SqlConnection._constructor();

  final String dbName = "getactive.db";

  SqlConnection._constructor();

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _getDatabase();
    return _db!;
  }

  Future<Database> _getDatabase() async {
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, dbName);
    final database = await openDatabase(
      databasePath,
      version: 1,
      onCreate: (db, version) async {
        createTables(db);
      },
    );
    return database;
  }

  static Future<void> resetDB() async {
    final db = await SqlConnection.instance.database;
    await deleteTables(db);
    await createTables(db);
  }

  static Future<void> createTables(Database db) async {
    await db.execute(TActivity.createTable());
    await db.execute(TActivityDone.createTable());
  }

  static Future<void> deleteTables(Database db) async {
    await db.execute(TActivity.deleteTable());
    await db.execute(TActivityDone.deleteTable());
  }
}
