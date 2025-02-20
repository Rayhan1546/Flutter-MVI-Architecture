import 'package:drift/drift.dart';
import 'package:github_repo_list/data/data_sources/local/drift/app_database/app_database.dart';
import 'package:github_repo_list/data/data_sources/local/drift/config_database/app_config_table.dart';

part 'app_config_dao.g.dart';

@DriftAccessor(tables: [AppConfigTable])
class AppConfigDao extends DatabaseAccessor<AppDatabase>
    with _$AppConfigDaoMixin {
  AppConfigDao(AppDatabase db) : super(db);

  Future<String?> getConfig(String key) async {
    final result = await (select(appConfigTable)
          ..where((tbl) => tbl.key.equals(key)))
        .getSingleOrNull();
    return result?.value;
  }

  Future<bool> setConfig(String key, String value) async {
    return transaction(() async {
      await into(appConfigTable).insertOnConflictUpdate(
        AppConfigTableCompanion.insert(
          key: key,
          value: value,
        ),
      );
      return true;
    });
  }

  Future<bool> removeConfig(String key) async {
    return transaction(() async {
      final count = await (delete(appConfigTable)
            ..where((tbl) => tbl.key.equals(key)))
          .go();
      return count > 0;
    });
  }

  Future<void> clearAllConfigs() async {
    await delete(appConfigTable).go();
  }
}
