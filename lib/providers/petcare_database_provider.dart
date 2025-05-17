import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class PetcareDatabaseProvider extends ChangeNotifier {
  final Database _database;

  PetcareDatabaseProvider(this._database);

  Database getDatabase() {
    return _database;
  }
}
