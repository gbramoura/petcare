class PetModel {
  final int id;
  final String name;
  final String breed;
  final DateTime bornDate;
  final String observation;

  PetModel({
    required this.id,
    required this.name,
    required this.breed,
    required this.bornDate,
    required this.observation,
  });

  factory PetModel.create({
    required String name,
    required String breed,
    required DateTime bornDate,
    required String observation,
  }) {
    return PetModel(
      name: name,
      breed: breed,
      bornDate: bornDate,
      observation: observation,
      id: 0,
    );
  }

  factory PetModel.fromMap(Map<String, dynamic> map) {
    return PetModel(
      id: map['id'] as int,
      name: map['name'] as String,
      breed: map['breed'] as String,
      bornDate: DateTime.parse(map['bornDate'] as String),
      observation: map['observation'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'breed': breed,
      'bornDate': bornDate.toIso8601String(),
      'observation': observation,
    };
  }
}
