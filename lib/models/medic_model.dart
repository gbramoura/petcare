class VaccineModel {
  final int id;
  final String medic;
  final DateTime date;
  final String healthStatus;
  final String observation;
  final int petId;

  VaccineModel({
    required this.medic,
    required this.date,
    required this.healthStatus,
    required this.observation,
    required this.id,
    required this.petId,
  });

  factory VaccineModel.create({
    required String medic,
    required DateTime date,
    required String healthStatus,
    required String observation,
    required int petId,
  }) {
    return VaccineModel(
      medic: medic,
      date: date,
      healthStatus: healthStatus,
      observation: observation,
      id: 0,
      petId: petId,
    );
  }

  factory VaccineModel.fromMap(Map<String, dynamic> map) {
    return VaccineModel(
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
}
