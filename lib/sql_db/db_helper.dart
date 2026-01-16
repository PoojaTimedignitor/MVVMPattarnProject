// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';
// import '../model/me_model.dart';
// import '../model/user_model.dart';
//
// class DBHelper{
//
//     static final DBHelper instance = DBHelper._internal();
//
//     static Database? _database;
//
//     DBHelper._internal();
//
//
//     Future<Database> get database async{
//         if(_database != null) return _database!;
//         _database = await initialized();
//          return _database!;
//     }
//
//     Future<Database> initialized()async{
//      String path = join(await getDatabasesPath(), "app_database.db");
//      return await openDatabase(
//          path,
//          version: 1,
//           onCreate: _onCreate,
//      );
//     }
//
//
//     Future _onCreate(Database db, int version)async{
//          await db.execute(
//             '''
//             CREATE TABLE users(
//                id INTEGER PRIMARY KEY AUTOINCREMENT,
//                name TEXT,
//                email TEXT
//
//                // name String,
//                // email String
//             )
//             '''
//          );
//     }
//
//
//     Future<int> addProduct(UserModel product)async {
//     // Future<int> addProduct(Map<String, dynamic> product)async {
//       final db = await instance.database;
//       return await db.insert('users', product.toMap());
//     }
//
//
//     Future<List<UserModel>> getProduct()async{
//         final db = await instance.database;
//         final List<Map<String, dynamic>>  result =  await  db.query('users');
//         return result.map((e) => UserModel.fromMap(e)).toList();
//     }
//
//
//     Future<int> updateProduct(UserModel product)async{
//     // Future<int> updateProduct(Map<String, dynamic> product)async{
//          final db = await instance.database;
//          return await db.update('users',
//              product.toMap(),
//              where:  'id  = ?',
//            whereArgs:  [product.id]
//          );
//     }
//
//
//     Future<int> deleteProduct(int id)async{
//        final db = await instance.database;
//        return await db.delete(
//            'users',
//          where: 'id = ?',
//          whereArgs: [id]
//        );
//     }
//
//
// }



import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/user_model.dart';

class DBHelper {
  static final DBHelper instance = DBHelper._internal();
  static Database? _database;

  DBHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), "app_database.db");
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        email TEXT
      )
    ''');
  }

  Future<int> addUser(UserModel user) async {
    final db = await database;
    return await db.insert('users', user.toMap());
  }

  Future<List<UserModel>> getUsers() async {
    final db = await database;
    final result = await db.query('users');
    return result.map((e) => UserModel.fromMap(e)).toList();
  }

  Future<int> deleteUser(int id) async {
    final db = await database;
    return await db.delete('users', where: 'id = ?', whereArgs: [id]);
  }
}
