import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:github_repo_list/data/data_sources/local/drift/config_database/app_config_dao.dart';
import 'package:github_repo_list/data/data_sources/local/drift/config_database/app_config_table.dart';
import 'package:github_repo_list/data/data_sources/local/drift/github_database/github_dao.dart';
import 'package:github_repo_list/data/data_sources/local/drift/github_database/github_table.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [GithubTable, AppConfigTable],
  daos: [GithubDao, AppConfigDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase._() : super(_openConnection());

  static final AppDatabase _instance = AppDatabase._();

  factory AppDatabase() {
    return _instance;
  }

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(
    () async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(p.join(dbFolder.path, 'appDatabase.db'));
      return NativeDatabase(file);
    },
  );
}
