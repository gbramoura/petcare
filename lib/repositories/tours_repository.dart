import 'package:petcare/models/tours_model.dart';
import 'package:sqflite/sqflite.dart';

class ToursRepository {
  final Database _db;
  final String _table = 'tours';

  ToursRepository(this._db);

  Future<int> create(ToursModel value) async {
    return _db.insert(
      _table,
      value.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> update(ToursModel value) async {
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

  Future<ToursModel> get(int id) async {
    var tours = await _db.query(
      _table,
      where: 'id = ?',
      whereArgs: [id],
    );

    return ToursModel.fromMap(tours[0]);
  }

  Future<List<ToursModel>> list() async {
    var tours = await _db.query(_table);

    return List.generate(tours.length, (i) {
      return ToursModel.fromMap(tours[i]);
    });
  }

  Future<List<ToursModel>> listWherePet(int petId) async {
    var tours = await _db.query(
      _table,
      where: 'petId = ?',
      whereArgs: [petId],
    );

    return List.generate(tours.length, (i) {
      return ToursModel.fromMap(tours[i]);
    });
  }
}
