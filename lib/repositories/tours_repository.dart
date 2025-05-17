import 'package:petcare/models/tours_model.dart';
import 'package:sqflite/sqflite.dart';

class ToursRepository {
  final Database _db;
  final String _table = 'tours';

  ToursRepository(this._db);

  void create(ToursModel value) async {
    await _db.insert(
      _table,
      value.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  void update(ToursModel value) async {
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
}
