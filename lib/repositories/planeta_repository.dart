import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:myapp/%20models/planeta.dart';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class PlanetaRepository {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }
  
  DatabaseFactory? get databaseFactoryFfi => null;

  Future<Database> _initDatabase() async {
    // Verifica se está rodando no Windows, Linux ou macOS
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      sqfliteFfiInit(); // Inicializa o sqflite_ffi corretamente
      databaseFactory = databaseFactoryFfi;
    }

    final path = join(await getDatabasesPath(), 'planetas.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE planetas (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nome TEXT NOT NULL,
            distancia_do_sol REAL NOT NULL,
            tamanho REAL NOT NULL,
            apelido TEXT
          )
        ''');
      },
    );
  }

  Future<int> inserirPlaneta(Planeta planeta) async {
    try {
      final db = await database;
      int id = await db.insert('planetas', planeta.toMap());
      if (kDebugMode) {
        print("Planeta inserido com sucesso: ${planeta.toMap()}");
      }
      return id;
    } catch (e) {
      if (kDebugMode) {
        print("Erro ao inserir planeta: $e");
      }
      return -1;
    }
  }

  Future<List<Planeta>> listarPlanetas() async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> maps = await db.query('planetas');
      if (kDebugMode) {
        print("Planetas carregados do banco: $maps");
      }
      return List.generate(maps.length, (i) {
        return Planeta.fromMap(maps[i]);
      });
    } catch (e) {
      if (kDebugMode) {
        print("Erro ao listar planetas: $e");
      }
      return [];
    }
  }

  Future<int> atualizarPlaneta(Planeta planeta) async {
    try {
      final db = await database;
      int resultado = await db.update(
        'planetas',
        planeta.toMap(),
        where: 'id = ?',
        whereArgs: [planeta.id],
      );
      if (kDebugMode) {
        print("Planeta atualizado: ${planeta.toMap()}");
      }
      return resultado;
    } catch (e) {
      if (kDebugMode) {
        print("Erro ao atualizar planeta: $e");
      }
      return -1;
    }
  }

  Future<int> excluirPlaneta(int id) async {
    try {
      final db = await database;
      int resultado = await db.delete('planetas', where: 'id = ?', whereArgs: [id]);
      if (kDebugMode) {
        print("Planeta com ID $id excluído");
      }
      return resultado;
    } catch (e) {
      if (kDebugMode) {
        print("Erro ao excluir planeta: $e");
      }
      return -1;
    }
  }
  
  void sqfliteFfiInit() {}
}
