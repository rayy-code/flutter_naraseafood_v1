import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';


class AppDatabase {
  static final AppDatabase instance = AppDatabase._init();

  static Database? _database;
  AppDatabase._init();

  final String tblCart = 'tbl_cart';
  final String tblDrinkCart = 'tbl_drink_cart';
  final String tblOrder = "tbl_order";
  final String tblPayment = "tbl_payment";
  final String tblSetting = "tbl_setting";
  final String tblMeals = "tbl_meals";
  final String tblDrinks = "tbl_drinks";

  Future<Database> get database async 
  {
    if(_database != null) return _database!;

    _database = await _initDB('naraseafood.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = dbPath + filePath;

    // Hapus database lama (opsional, jika diperlukan)
    await deleteDatabase(path);
    debugPrint("Database Path: $path"); // Cek lokasi database

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
      readOnly: false,
    );
  }
  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tblCart (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      idCart INTEGER,
      idMeal TEXT,
      strMeal TEXT,
      strMealThumb TEXT,
      qty INTEGER,
      price INTEGER
      )''');

      await db.execute('''
      CREATE TABLE $tblDrinkCart (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      idDrinkCart INTEGER,
      idDrink TEXT,
      strDrink TEXT,
      strDrinkThumb TEXT,
      qty INTEGER,
      price INTEGER
      )''');

      await db.execute('''
      CREATE TABLE $tblOrder (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      idOrder INTEGER,
      idMealCart INTEGER NULLABLE,
      idDrinkCart INTEGER NULLABLE,
      totalPrice INTEGER
      )''');

      await db.execute('''
      CREATE TABLE $tblPayment (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      idPayment INTEGER,
      idOrder INTEGER,
      totalPrice INTEGER,
      pay INTEGER,
      excessMoney INTEGER
      )''');

      await db.execute('''
      CREATE TABLE $tblMeals (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      strMeal TEXT,
      strMealThumb TEXT,
      price INTEGER
      )''');

      await db.execute('''
      CREATE TABLE $tblDrinks (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      strDrink TEXT,
      strDrinkThumb TEXT,
      price INTEGER
      )''');

      await db.execute('''
      CREATE TABLE $tblSetting (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      settingName String,
      value String
      )''');

      await db.execute('''
      INSERT INTO $tblSetting (
      settingName,
      value) VALUES (
      "loadData", "api"),
      ("apiFood","https://www.themealdb.com/api/json/v1/1/filter.php?c=Seafood"),
      ("apiDrink","https://www.thecocktaildb.com/api/json/v1/1/filter.php?a=Non_Alcoholic")''');

  }



}