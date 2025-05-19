import 'package:petcare/models/pet_model.dart';
import 'package:sqflite/sqflite.dart';

class PetsRepository {
  final Database _db;
  final String _table = 'pets';

  PetsRepository(this._db);

  Future<int> create(PetModel value) async {
    return _db.insert(
      _table,
      value.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> update(PetModel value) async {
    return _db.update(
      _table,
      value.toMap(),
      where: 'id = ?',
      whereArgs: [value.id],
    );
  }

  Future<int> delete(int id) async {
    return _db.delete(
      _table,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<PetModel> get(int id) async {
    var pets = await _db.query(
      _table,
      where: 'id = ?',
      whereArgs: [id],
    );

    return PetModel.fromMap(pets[0]);
  }

  Future<List<PetModel>> list() async {
    var pets = await _db.query(_table);

    return List.generate(pets.length, (i) {
      return PetModel.fromMap(pets[i]);
    });
  }
}
