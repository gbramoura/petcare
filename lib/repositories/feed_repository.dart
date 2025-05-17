import 'package:petcare/models/feed_model.dart';
import 'package:sqflite/sqflite.dart';

class FeedRepository {
  final Database _db;
  final String _table = 'feeds';

  FeedRepository(this._db);

  void create(FeedModel value) async {
    await _db.insert(
      _table,
      value.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  void update(FeedModel value) async {
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
}
