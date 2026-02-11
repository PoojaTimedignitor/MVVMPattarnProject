
import 'dart:developer';
import 'dart:io';
import 'package:clean_mvvm_pattern/model/me_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../../model/product_db_model.dart';

class DBHelper {
  static final DBHelper instance = DBHelper._internal();
  static Database? _database;

  DBHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    log('Database : $_database');
    return _database!;
  }

  Future<Database> _initDB() async {
    Directory directory = await getApplicationDocumentsDirectory();                      /// new
    // final directoryPath  = await getDatabasesPath();     ///old
    final path = join(directory.path, "app_database.db");
    log('Path : $path');
    return await openDatabase(
      path,
      version: 3,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('ALTER TABLE users ADD COLUMN age INTEGER');
    }

    if (oldVersion < 3) {
      await db.execute('''
      CREATE TABLE products(
        id INTEGER PRIMARY KEY,
        title TEXT,
        price REAL,
        thumbnail TEXT
      )
    ''');
    }
  }


  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        firstName TEXT,
        lastName TEXT,
        email TEXT,
        gender TEXT,
        age INTEGER,
        image TEXT
      )
    ''');

    /// Add new Product store  10-2-26
    await db.execute('''
       CREATE TABLE products(
       id INTEGER PRIMARY KEY,
       title TEXT,
       price REAL,
       thumbnail TEXT
       )
    ''');
  }

  Future<int> addUser(MeModel user) async {
    final db = await database;
    return await db.insert('users', user.toDbMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<MeModel>> getUsers() async {
    final db = await database;
    final result = await db.query('users');
    log('Get User : $result');
    return result.map((e) => MeModel.fromDbMap(e)).toList();
  }

  Future<int> deleteUser(int id) async {
    final db = await database;
    log('delete User : $db');
    return await db.delete('users', where: 'id = ?', whereArgs: [id]);
  }



  /// Add new Product store  10-2-26
  Future<void> insertProduct(List<ProductDbModel> products)async{
  // Future<int> insertProduct(List<ProductDbModel> products)async{
    final db = await database;
    final batch = db.batch();
    for (final product in products) {
      batch.insert(
        'products',
        product.toDbMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    await batch.commit(noResult: true);
    //return await db.insert('products', products.toDbMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }


  Future<List<ProductDbModel>> fetchProducts()async{
     final db = await database;
     final result = await db.query('products');
     return result.map((e) => ProductDbModel.fromDbMap(e)).toList();
  }



}




