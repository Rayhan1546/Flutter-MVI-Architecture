import 'package:github_repo_list/data/data_sources/local/sqflite/app_database.dart';
import 'package:github_repo_list/data/data_sources/local/storage_manager/mappable_mixin.dart';
import 'package:sqflite/sqflite.dart';

abstract class DatabaseStorageManager<T> with MappableMixin<T> {
  late final SqfliteAppDatabase _database = SqfliteAppDatabase(
    tableName: tableName,
    schema: schema,
  );

  String get tableName;
  Map<String, String> get schema;

  Future<Database> get database async => await _database.database;

  Future<int> insert(T value) async {
    final db = await database;
    return await db.insert(
      tableName,
      toJson(value),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<T>> getAll() async {
    final db = await database;
    final maps = await db.query(tableName);
    return maps.map((map) => fromJson(map)).toList();
  }

  Future<int> update(int id, T value) async {
    final db = await database;
    return await db.update(
      tableName,
      toJson(value),
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> delete(int id) async {
    final db = await database;
    return await db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> clear() async {
    final db = await database;
    await db.delete(tableName);
  }
}
