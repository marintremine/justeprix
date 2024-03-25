import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/objet.dart';
import '../models/resultat.dart';

class DatabaseHelper {
  static late Database _database;
  final String objetTable = 'OBJET';
  final String resultatTable = 'RESULTATS';

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDatabase();
    return _database;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'juste_prix.db');
    return openDatabase(path, onCreate: (db, version) async {
      await db.execute('''
          CREATE TABLE $objetTable (
            id_O TEXT PRIMARY KEY,
            nom TEXT,
            image TEXT,
            description TEXT,
            prix INTEGER
          )
          ''');
      await db.execute('''
          CREATE TABLE $resultatTable (
            id_R TEXT PRIMARY KEY,
            user TEXT,
            niveau TEXT,
            datetime TEXT,
            id_O TEXT,
            FOREIGN KEY (id_O) REFERENCES OBJET (id_O)
          )
          ''');
    }, version: 1);
  }

  Future<List<Objet>> getAllObjets() async {
    final db = await database;
    var res = await db.query(objetTable);
    List<Objet> objets = res.isNotEmpty ? res.map((c) => Objet.fromJson(c)).toList() : [];
    return objets;
  }

  Future<Objet?> getObjetById(String id) async {
    final db = await database;
    var res = await db.query(objetTable, where: 'id_O = ?', whereArgs: [id]);
    return res.isNotEmpty ? Objet.fromJson(res.first) : null;
  }

  Future<int> insertResultat(Resultat resultat) async {
    final db = await database;
    return await db.insert(resultatTable, resultat.toJson());
  }
}
