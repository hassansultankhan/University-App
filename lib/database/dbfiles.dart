import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'dart:io';
import 'package:university_app_latest/database/likeduniversity.dart';

class Dbfiles {
  Dbfiles();

  static late Database _db;

  Future<Database> get db async {
    _db = await initializeDb();
    return _db;
  }

  Future<Database> initializeDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    // String path = await getDatabasesPath();
    String dbPath = join(await documentDirectory.path, "universities.db");
    var uniDb = await openDatabase(dbPath, version: 1, onCreate: createTable);
    return uniDb;
  }

  FutureOr<void> createTable(Database db, int version) async {
    await db.execute('''Create table universities(
            id integer primary key, 
            name text, 
            url text)
            ''');
  }

  Future<List> getuniversities() async {
    Database db = await this.db;
    var result = await db.query("universities");
    return List.generate(result.length, (i) {
      return likedUniversity.fromKeyValue(result[i]);
    });
  }

  Future<int> insert(likedUniversity likeduniversity) async {
    Database db = await this.db;
    var result = await db.insert("universities", likeduniversity.toKeyValue());
    return result;
  }

  Future<int> delete(int id) async {
    Database db = await this.db;
    var result = await db.rawDelete("delete from universities where id = $id");
    return result;
  }
}
