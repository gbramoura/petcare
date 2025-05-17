import 'package:path/path.dart';
import 'package:petcare/models/feed_model.dart';
import 'package:petcare/models/medic_model.dart';
import 'package:petcare/models/pet_model.dart';
import 'package:petcare/models/tours_model.dart';
import 'package:petcare/models/vaccine_model.dart';
import 'package:sqflite/sqflite.dart';

class PetCareDatabase {
  static Future<Database> open() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'petcare_database.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(PetModel.getCreateTableQuery());
        await db.execute(VaccineModel.getCreateTableQuery());
        await db.execute(ToursModel.getCreateTableQuery());
        await db.execute(FeedModel.getCreateTableQuery());
        await db.execute(MedicModel.getCreateTableQuery());
      },
    );
  }
}
