class VaccineModel {
  final int id;
  final String name;
  final DateTime date;
  final String observation;
  final int petId;

  VaccineModel({
    required this.id,
    required this.name,
    required this.date,
    required this.observation,
    required this.petId,
  });

  factory VaccineModel.create({
    required String name,
    required DateTime date,
    required String observation,
    required int petId,
  }) {
    return VaccineModel(
      name: name,
      date: date,
      observation: observation,
      id: 0,
      petId: petId,
    );
  }

  factory VaccineModel.fromMap(Map<String, dynamic> map) {
    return VaccineModel(
      id: map['id'] as int,
      name: map['name'] as String,
      date: DateTime.parse(map['date'] as String),
      observation: map['observation'] as String,
      petId: map['petId'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'date': date.toIso8601String(),
      'observation': observation,
      'petId': petId,
    };
  }
}
