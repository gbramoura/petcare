import 'package:petcare/models/medic_model.dart';
import 'package:sqflite/sqflite.dart';

class MedicRepository {
  final Database _db;
  final String _table = 'medics';

  MedicRepository(this._db);

  void create(MedicModel value) async {
    await _db.insert(
      _table,
      value.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  void update(MedicModel value) async {
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

  Future<MedicModel> get(int id) async {
    var medics = await _db.query(
      _table,
      where: 'id = ?',
      whereArgs: [id],
    );

    return MedicModel.fromMap(medics[0]);
  }

  Future<List<MedicModel>> list() async {
    var medics = await _db.query(_table);

    return List.generate(medics.length, (i) {
      return MedicModel.fromMap(medics[i]);
    });
  }
}
