import 'package:favorite_places_app/models/place_model.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

// MAP -> SAVE DATABASE.
// DATA BASE DATA -> MAP -> CONVERT INTO OBJECT OR LIST.

class DBHelper {
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, 'places.db'),
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE user_places('
          'id TEXT PRIMARY KEY, '
          'title TEXT, '
          'image TEXT, '
          'lat REAL, '
          'lng REAL, '
          'address TEXT'
          ')',
        );
      },
    );
  }

  static Future<DBResult> insert(
    String table,
    Map<String, Object> data,
  ) async {
    try {
      final db = await database();
      await db.insert(
        table,
        data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace,
      );
      debugPrint(data.toString());
      return DBResult.success;
    } catch (e) {
      return DBResult.failure;
    }
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    try {
      final db = await database();
      final data = await db.query(table);
      return data;
    } catch (e) {
      return [];
    }
  }

  static Future<DBResult> delete(String table, String id) async {
    try {
      final db = await database();
      final count = await db.delete(
        table,
        where: 'id = ?',
        whereArgs: [id],
      );
      if (count == 0) {
        return DBResult.notFound;
      }
      return DBResult.success;
    } catch (e) {
      return DBResult.failure;
    }
  }
}
