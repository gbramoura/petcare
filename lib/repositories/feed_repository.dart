import 'package:petcare/models/feed_model.dart';
import 'package:sqflite/sqflite.dart';

class FeedRepository {
  final Database _db;
  final String _table = 'feeds';

  FeedRepository(this._db);

  Future<int> create(FeedModel value) async {
    return _db.insert(
      _table,
      value.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> update(FeedModel value) async {
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

  Future<FeedModel> get(int id) async {
    var feeds = await _db.query(
      _table,
      where: 'id = ?',
      whereArgs: [id],
    );

    return FeedModel.fromMap(feeds[0]);
  }

  Future<List<FeedModel>> list() async {
    var feeds = await _db.query(_table);

    return List.generate(feeds.length, (i) {
      return FeedModel.fromMap(feeds[i]);
    });
  }

  Future<List<FeedModel>> listWherePet(int petId) async {
    var tours = await _db.query(
      _table,
      where: 'petId = ?',
      whereArgs: [petId],
    );

    return List.generate(tours.length, (i) {
      return FeedModel.fromMap(tours[i]);
    });
  }
}
