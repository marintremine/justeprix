import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/objet.dart';
import '../models/resultat.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  DatabaseHelper._privateConstructor();

  factory DatabaseHelper() => _instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<void> delDatabase() async {
    String path = join(await getDatabasesPath(), 'scores.db');
    await deleteDatabase(path);
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'scores.db');
    return await openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE objet (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nom TEXT,
        image TEXT,
        description TEXT,
        prix INTEGER
      )
    ''');
    await db.execute('''
      CREATE TABLE resultat (
        id INTEGER PRIMARY KEY,
        user TEXT,
        niveau TEXT,
        datetime TEXT,
        id_O INTEGER,
        FOREIGN KEY (id_O) REFERENCES objet (id)
      )
    ''');
  }

  Future<void> clearDatabase() async {
    Database db = await database;
    await db.execute('DELETE FROM objet');
    await db.execute('DELETE FROM resultat');
  }

  Future<void> insertObjet(Objet objet) async {
    Database db = await database;
    await db.insert('objet', objet.toMap());
  }

  Future<List<Objet>> getAllObjet() async {
    Database db = await database;
    List<Map<String, Object?>> results = await db.query('objet');
    return results.map((result) => Objet.fromMap(result)).toList();
  }

  Future<Objet> getObjetById(String id) async {
    Database db = await database;
    List<Map<String, Object?>> results = await db.query('objet', where: 'id = ?', whereArgs: [id]);
    return Objet.fromMap(results.first);
  }

  Future<void> updateObjet(Objet objet) async {
    Database db = await database;
    await db.update('objet', objet.toMap(), where: 'id = ?', whereArgs: [objet.id]);
  }

  Future<void> deleteObjet(String id) async {
    Database db = await database;
    await db.delete('objet', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> deleteAllObjet() async {
    Database db = await database;
    await db.delete('objet');
  }

  Future<void> insertResultat(Resultat resultat) async {
    Database db = await database;
    await db.insert('resultat', resultat.toMap());
  }

  Future<List<Resultat>> getAllResultat() async {
    Database db = await database;
    List<Map<String, Object?>> results = await db.query('resultat');
    return results.map((result) => Resultat.fromMap(result)).toList();
  }

  Future<Resultat> getResultatById(String id) async {
    Database db = await database;
    List<Map<String, Object?>> results = await db.query('resultat', where: 'id = ?', whereArgs: [id]);
    return Resultat.fromMap(results.first);
  }

  Future<void> updateResultat(Resultat resultat) async {
    Database db = await database;
    await db.update('resultat', resultat.toMap(), where: 'id = ?', whereArgs: [resultat.id]);
  }

  Future<void> deleteResultat(String id) async {
    Database db = await database;
    await db.delete('resultat', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> deleteAllResultat() async {
    Database db = await database;
    await db.delete('resultat');
  }

}
