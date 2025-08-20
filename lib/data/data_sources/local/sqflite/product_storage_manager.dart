import 'package:github_repo_list/data/data_sources/local/sqflite/database_storage_manager.dart';

class Product {
  final int? id;
  final String name;
  final double price;
  final String category;
  final bool inStock;
  final String? createdAt;

  Product({
    this.id,
    required this.name,
    required this.price,
    required this.category,
    required this.inStock,
    this.createdAt,
  });

  Product copyWith({
    int? id,
    String? name,
    double? price,
    String? category,
    bool? inStock,
    String? createdAt,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      category: category ?? this.category,
      inStock: inStock ?? this.inStock,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class ProductStorageManager extends DatabaseStorageManager<Product> {
  @override
  String get tableName => 'products';

  @override
  Map<String, String> get schema => {
        'id': 'INTEGER PRIMARY KEY AUTOINCREMENT',
        'name': 'TEXT NOT NULL',
        'price': 'REAL NOT NULL',
        'category': 'TEXT',
        'in_stock': 'INTEGER DEFAULT 1',
        'created_at': 'TEXT DEFAULT CURRENT_TIMESTAMP'
      };

  @override
  Product fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int?,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      category: json['category'] as String,
      inStock: (json['in_stock'] as int) == 1,
      createdAt: json['created_at'] as String?,
    );
  }

  @override
  Map<String, dynamic> toJson(Product value) {
    return <String, dynamic>{
      if (value.id != null) 'id': value.id,
      'name': value.name,
      'price': value.price,
      'category': value.category,
      'in_stock': value.inStock ? 1 : 0,
    };
  }

  Future<List<Product>> getProductsByCategory(String category) async {
    final db = await database;
    final maps = await db.query(
      tableName,
      where: 'category = ?',
      whereArgs: [category],
    );

    return maps.map((map) => fromJson(map)).toList();
  }

  Future<List<Product>> getInStockProducts() async {
    final db = await database;
    final maps = await db.query(
      tableName,
      where: 'in_stock = ?',
      whereArgs: [1],
    );

    return maps.map((map) => fromJson(map)).toList();
  }
}
