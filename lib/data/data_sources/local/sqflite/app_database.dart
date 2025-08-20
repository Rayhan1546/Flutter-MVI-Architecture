import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqfliteAppDatabase {
  final String tableName;
  final Map<String, String> schema;

  SqfliteAppDatabase({
    required this.tableName,
    required this.schema,
  });

  String databaseName = 'app_database.db';
  Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, databaseName);

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        final columns =
            schema.entries.map((e) => '${e.key} ${e.value}').join(', ');
        await db.execute('CREATE TABLE $tableName ($columns)');
      },
    );
  }
}
