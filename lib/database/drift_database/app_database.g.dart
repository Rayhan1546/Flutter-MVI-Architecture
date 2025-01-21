// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $GithubTableTable extends GithubTable
    with TableInfo<$GithubTableTable, GithubTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GithubTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _imgUrlMeta = const VerificationMeta('imgUrl');
  @override
  late final GeneratedColumn<String> imgUrl = GeneratedColumn<String>(
      'img_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, name, imgUrl, description];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'github_table';
  @override
  VerificationContext validateIntegrity(Insertable<GithubTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('img_url')) {
      context.handle(_imgUrlMeta,
          imgUrl.isAcceptableOrUnknown(data['img_url']!, _imgUrlMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  GithubTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GithubTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      imgUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}img_url']),
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
    );
  }

  @override
  $GithubTableTable createAlias(String alias) {
    return $GithubTableTable(attachedDatabase, alias);
  }
}

class GithubTableData extends DataClass implements Insertable<GithubTableData> {
  final int id;
  final String name;
  final String? imgUrl;
  final String? description;
  const GithubTableData(
      {required this.id, required this.name, this.imgUrl, this.description});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || imgUrl != null) {
      map['img_url'] = Variable<String>(imgUrl);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    return map;
  }

  GithubTableCompanion toCompanion(bool nullToAbsent) {
    return GithubTableCompanion(
      id: Value(id),
      name: Value(name),
      imgUrl:
          imgUrl == null && nullToAbsent ? const Value.absent() : Value(imgUrl),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
    );
  }

  factory GithubTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GithubTableData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      imgUrl: serializer.fromJson<String?>(json['imgUrl']),
      description: serializer.fromJson<String?>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'imgUrl': serializer.toJson<String?>(imgUrl),
      'description': serializer.toJson<String?>(description),
    };
  }

  GithubTableData copyWith(
          {int? id,
          String? name,
          Value<String?> imgUrl = const Value.absent(),
          Value<String?> description = const Value.absent()}) =>
      GithubTableData(
        id: id ?? this.id,
        name: name ?? this.name,
        imgUrl: imgUrl.present ? imgUrl.value : this.imgUrl,
        description: description.present ? description.value : this.description,
      );
  GithubTableData copyWithCompanion(GithubTableCompanion data) {
    return GithubTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      imgUrl: data.imgUrl.present ? data.imgUrl.value : this.imgUrl,
      description:
          data.description.present ? data.description.value : this.description,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GithubTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('imgUrl: $imgUrl, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, imgUrl, description);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GithubTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.imgUrl == this.imgUrl &&
          other.description == this.description);
}

class GithubTableCompanion extends UpdateCompanion<GithubTableData> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> imgUrl;
  final Value<String?> description;
  final Value<int> rowid;
  const GithubTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.imgUrl = const Value.absent(),
    this.description = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GithubTableCompanion.insert({
    required int id,
    required String name,
    this.imgUrl = const Value.absent(),
    this.description = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name);
  static Insertable<GithubTableData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? imgUrl,
    Expression<String>? description,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (imgUrl != null) 'img_url': imgUrl,
      if (description != null) 'description': description,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GithubTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String?>? imgUrl,
      Value<String?>? description,
      Value<int>? rowid}) {
    return GithubTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      imgUrl: imgUrl ?? this.imgUrl,
      description: description ?? this.description,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (imgUrl.present) {
      map['img_url'] = Variable<String>(imgUrl.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GithubTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('imgUrl: $imgUrl, ')
          ..write('description: $description, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $GithubTableTable githubTable = $GithubTableTable(this);
  late final GithubDao githubDao = GithubDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [githubTable];
}

typedef $$GithubTableTableCreateCompanionBuilder = GithubTableCompanion
    Function({
  required int id,
  required String name,
  Value<String?> imgUrl,
  Value<String?> description,
  Value<int> rowid,
});
typedef $$GithubTableTableUpdateCompanionBuilder = GithubTableCompanion
    Function({
  Value<int> id,
  Value<String> name,
  Value<String?> imgUrl,
  Value<String?> description,
  Value<int> rowid,
});

class $$GithubTableTableFilterComposer
    extends Composer<_$AppDatabase, $GithubTableTable> {
  $$GithubTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get imgUrl => $composableBuilder(
      column: $table.imgUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));
}

class $$GithubTableTableOrderingComposer
    extends Composer<_$AppDatabase, $GithubTableTable> {
  $$GithubTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get imgUrl => $composableBuilder(
      column: $table.imgUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));
}

class $$GithubTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $GithubTableTable> {
  $$GithubTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get imgUrl =>
      $composableBuilder(column: $table.imgUrl, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);
}

class $$GithubTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $GithubTableTable,
    GithubTableData,
    $$GithubTableTableFilterComposer,
    $$GithubTableTableOrderingComposer,
    $$GithubTableTableAnnotationComposer,
    $$GithubTableTableCreateCompanionBuilder,
    $$GithubTableTableUpdateCompanionBuilder,
    (
      GithubTableData,
      BaseReferences<_$AppDatabase, $GithubTableTable, GithubTableData>
    ),
    GithubTableData,
    PrefetchHooks Function()> {
  $$GithubTableTableTableManager(_$AppDatabase db, $GithubTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GithubTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GithubTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GithubTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> imgUrl = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              GithubTableCompanion(
            id: id,
            name: name,
            imgUrl: imgUrl,
            description: description,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required int id,
            required String name,
            Value<String?> imgUrl = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              GithubTableCompanion.insert(
            id: id,
            name: name,
            imgUrl: imgUrl,
            description: description,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$GithubTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $GithubTableTable,
    GithubTableData,
    $$GithubTableTableFilterComposer,
    $$GithubTableTableOrderingComposer,
    $$GithubTableTableAnnotationComposer,
    $$GithubTableTableCreateCompanionBuilder,
    $$GithubTableTableUpdateCompanionBuilder,
    (
      GithubTableData,
      BaseReferences<_$AppDatabase, $GithubTableTable, GithubTableData>
    ),
    GithubTableData,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$GithubTableTableTableManager get githubTable =>
      $$GithubTableTableTableManager(_db, _db.githubTable);
}
