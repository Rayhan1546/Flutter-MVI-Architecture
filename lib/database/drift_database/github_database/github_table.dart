import 'package:drift/drift.dart';

class GithubTable extends Table {
  IntColumn get id => integer()();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  TextColumn get imgUrl => text().nullable()();
  TextColumn get description => text().nullable()();
}
