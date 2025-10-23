import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

class LocalDatabaseService {
  static final LocalDatabaseService _instance = LocalDatabaseService._();
  LocalDatabaseService._();
  factory LocalDatabaseService() => _instance;

  Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _open();
    return _db!;
  }

  Future<Database> _open() async {
    final dbPath = await getDatabasesPath();
    final path = p.join(dbPath, 'thuso_vhathuni.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE user_profile (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          full_name TEXT NOT NULL,
          age INTEGER NOT NULL,
          condition TEXT NOT NULL
        );
        ''');
        await db.execute('''
        CREATE TABLE clinic_visit (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          date TEXT NOT NULL,
          location TEXT NOT NULL,
          reason TEXT NOT NULL
        );
        ''');
        await db.execute('''
        CREATE TABLE medication (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL,
          dosage TEXT NOT NULL,
          frequency TEXT NOT NULL
        );
        ''');
      },
    );
  }
}


