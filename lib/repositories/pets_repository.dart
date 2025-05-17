import 'package:petcare/models/pet_model.dart';
import 'package:sqflite/sqflite.dart';

class PetsRepository {
  final Database _db;
  final String _table = 'pets';

  PetsRepository(this._db);

  void create(PetModel value) async {
    await _db.insert(
      _table,
      value.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  void update(PetModel value) async {
    await _db.update(
      _table,
      value.toMap(),
      where: 'id = ?',
      whereArgs: [value.id],
    );
  }

  void delete(int id) async {
    await _db.delete(
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
