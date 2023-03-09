import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class DBHelperProgress {
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'progress2.db'),
        onCreate: (db, version) async {
          return db.execute('CREATE TABLE Progress2(schwierigkeit TEXT, kategorie TEXT, wort TEXT,roderf INTEGER,hilfe INTEGER)');
        }, version: 1);
  }


  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DBHelperProgress.database();
    db.insert(table, data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelperProgress.database();
    return db.query(table);
  }
}