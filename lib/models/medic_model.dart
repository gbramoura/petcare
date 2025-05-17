class MedicModel {
  final int id;
  final String medic;
  final DateTime date;
  final String healthStatus;
  final String observation;
  final int petId;

  MedicModel({
    required this.medic,
    required this.date,
    required this.healthStatus,
    required this.observation,
    required this.id,
    required this.petId,
  });

  factory MedicModel.create({
    required String medic,
    required DateTime date,
    required String healthStatus,
    required String observation,
    required int petId,
  }) {
    return MedicModel(
      medic: medic,
      date: date,
      healthStatus: healthStatus,
      observation: observation,
      id: 0,
      petId: petId,
    );
  }

  factory MedicModel.fromMap(Map<String, dynamic> map) {
    return MedicModel(
      id: map['id'] as int,
      medic: map['medic'] as String,
      date: DateTime.parse(map['date'] as String),
      healthStatus: map['healthStatus'] as String,
      observation: map['observation'] as String,
      petId: map['petId'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'medic': medic,
      'date': date.toIso8601String(),
      'healthStatus': healthStatus,
      'observation': observation,
      'petId': petId,
    };
  }

  static String getCreateTableQuery() {
    return '''
      CREATE TABLE IF NOT EXISTS medics  (
        id INTEGER AUTO_INCREMENT,
        medic TEXT NOT NULL,
        date TEXT NOT NULL,
        healthStatus TEXT NOT NULL,
        observation TEXT,
        petId INTEGER NOT NULL,
        PRIMARY KEY(id),
        FOREIGN KEY(petId) REFERENCES pets(id)
      );
    ''';
  }
}
