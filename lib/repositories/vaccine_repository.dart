import 'package:petcare/models/vaccine_model.dart';
import 'package:sqflite/sqflite.dart';

class VaccineRepository {
  final Database _db;
  final String _table = 'vaccines';

  VaccineRepository(this._db);

  Future<void> create(VaccineModel value) async {
    await _db.insert(
      _table,
      value.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> update(VaccineModel value) async {
    await _db.update(
      _table,
      value.toMap(),
      where: 'id = ?',
      whereArgs: [value.id],
    );
  }

  Future<void> delete(int id) async {
    await _db.delete(
      _table,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<VaccineModel> get(int id) async {
    var vaccines = await _db.query(
      _table,
      where: 'id = ?',
      whereArgs: [id],
    );

    return VaccineModel.fromMap(vaccines[0]);
  }

  Future<List<VaccineModel>> list() async {
    var vaccines = await _db.query(_table);

    return List.generate(vaccines.length, (i) {
      return VaccineModel.fromMap(vaccines[i]);
    });
  }
}
