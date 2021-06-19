import 'package:fit/helper/constance.dart';
import 'package:fit/model/product.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DatabaseHelper {
  static final DatabaseHelper _singleton = DatabaseHelper._();

  factory DatabaseHelper() {
    return _singleton;
  }

  /// using single ton and take instance private my class
  DatabaseHelper._();

  static Database _database;

  /// using this get to check if have database or not.

  initDB() async {
    String path = join(await getDatabasesPath(), "UserData.db");
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
        CREATE TABLE Product(
          Pid TEXT NOT NUll,
          PCategory TEXT NOT NUll,
          PDiscribtion TEXT NOT NULL,
          PLink TEXT NOT NULL,
          PName TEXT NOT NULL,
          PPrice TEXT NOT NULL,
          PQuantity INTEGER NOT NULL, 
          protin TEXT NOT NULL,
          cal TEXT NOT NULL,
          fat TEXT NOT NULL,
          carbs TEXT NOT NUll,
          side1 TEXT NULL,
          side2 TEXT NULL,
          price2 TEXT NOT NULL,
          size TEXT NULL,
          com TEXT NULL,
          PPorder TEXT NULL
         
          
         
          
        )
     ''');
    });
  }

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();
    return _database;
  }

  ///CURD
  Future<Product> insertProduct(Product product, List<Product> p, var c) async {
    var dbProduct = await database;
    List<Product> s = [];
    bool x = false;
// ignore: unused_local_variable
    var e = DatabaseHelper()
        .getAllProduct(p)
        .then((value) => {print(value), s = value});

    for (var p in s) {
      if (product.pid == p.pid) {
        x = true;
      }
    }

    if (x == true) {
      return c;
    } else {
      await dbProduct.insert(
        tableProduct,
        product.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      p.add(product);
      return product;
    }
  }

  /// update product by id
  Future<void> updateProduct(Product product) async {
    var dbProduct = await database;
    return await dbProduct.update(tableProduct, product.toJson(),
        where: 'Pid = ?', whereArgs: [product.pid]);
  }

  /// get one product
  Future<Product> getProduct(int id) async {
    var dbProduct = await database;
    List<Map<dynamic, dynamic>> maps =
        await dbProduct.query(tableProduct, where: 'Pid = ? ', whereArgs: [id]);
    if (maps.length > 0) {
      return Product.fromJson(maps.first);
    } else {
      return null;
    }
  }

  /// get all product
  Future<List<Product>> getAllProduct(
    p,
  ) async {
    var dbProduct = await database;
    print(dbProduct.toString());

    List<Map> maps = await dbProduct.query(tableProduct);
    List<Product> list = [];

    list = maps.isNotEmpty ? maps.map((e) => Product.fromJson(e)).toList() : p;

    print(list.length);

    return list;
  }

  Future<int> getAllProductlenght(e) async {
    var dbProduct = await database;
    print(dbProduct.toString());

    List<Map> maps = await dbProduct.query(tableProduct);
    List<Product> list = [];

    list = maps.isNotEmpty ? maps.map((e) => Product.fromJson(e)).toList() : 0;

    print(list.length);
    int e = list.length;

    return e;
  }

  /// delete product by id
  Future<void> deleteProduct(String id, List<Product> products) async {
    var dbProduct = await database;
    for (var p in products) {
      if (p.pid == id) {
        products.remove(p);

        return await dbProduct
            .delete(tableProduct, where: 'Pid = ? ', whereArgs: [id]);
      } else {
        return await dbProduct
            .delete(tableProduct, where: 'Pid = ? ', whereArgs: [id]);
      }
    }
    return await dbProduct
        .delete(tableProduct, where: 'Pid = ? ', whereArgs: [id]);
  }
}
