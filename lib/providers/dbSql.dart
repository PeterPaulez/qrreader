import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import 'package:qrmapurl/models/scan.dart';

class DBSqlProvider {
  static Database _database;
  static final DBSqlProvider db = DBSqlProvider._();
  DBSqlProvider._(); // De esta forma, siempre obetenemos un sigleton con la misma instancia

  // GETTER de nuestra BBDD
  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();
    return _database;
  }

  // Creamos la DB en el dispositivo
  Future<Database> initDB() async {
    // Path de la app donde guardaremos la DDBB
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path =
        join(documentsDirectory.path, 'DBSqlProvider.db'); // Unir cosas
    print('Path: $path');

    // Devolver la creación de la DB
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE Scans(
            id INTEGER PRIMARY KEY,
            tipo TEXT,
            valor TEXT
          )
        '''); // Triple ' para hacer una query multilinea
      },
    ); // Version si cambias STRUCTURA de las tablas para saber donde esta todo
  }

  Future<int> nuevoScanRaw(ScanModel tempScan) async {
    final id = tempScan.id;
    final tipo = tempScan.tipo;
    final valor = tempScan.valor;
    final db = await database;

    final response = await db.rawInsert('''
    INSERT INTO Scans (id,tipo,valor)
    VALUES ('$id','$tipo','$valor')
    ''');
    return response;
  }

  Future<int> nuevoScan(ScanModel tempScan) async {
    final db = await database;

    final response = await db.insert('Scans', tempScan.toJson());
    print('ID último producto: $response');
    return response;
  }

  Future<ScanModel> getScanById(int id) async {
    final db = await database;
    final response = await db.query('Scans', where: 'id=?', whereArgs: [id]);
    return response.isNotEmpty ? ScanModel.fromJson(response[0]) : null;
  }

  Future<List<ScanModel>> getScansAll() async {
    final db = await database;
    final response = await db.query('Scans');
    return response.isNotEmpty
        ? response.map((e) => ScanModel.fromJson(e)).toList()
        : null;
  }

  Future<List<ScanModel>> getScansByTipo(String tipo) async {
    final db = await database;
    final response =
        await db.query('Scans', where: 'tipo=?', whereArgs: [tipo]);
    return response.isNotEmpty
        ? response.map((e) => ScanModel.fromJson(e)).toList()
        : null;
  }

  Future<int> editScan(ScanModel tempScan) async {
    final db = await database;
    final response = db.update(
      'Scans',
      tempScan.toJson(),
      where: 'id=?',
      whereArgs: [tempScan.id],
    );
    return response;
  }

  Future<int> borrarScanById(int id) async {
    final db = await database;
    final response = await db.delete(
      'Scans',
      where: 'id=?',
      whereArgs: [id],
    );
    return response;
  }

  Future<int> borrarScansAll() async {
    final db = await database;
    final response = await db.rawDelete('''
    DELETE FROM Scans
    ''');
    return response;
  }
}
