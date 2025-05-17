class FeedModel {
  final int id;
  final String name;
  final num weight;
  final String observation;
  final int petId;

  FeedModel({
    required this.id,
    required this.name,
    required this.weight,
    required this.observation,
    required this.petId,
  });

  factory FeedModel.create({
    required String name,
    required num weight,
    required String observation,
    required int petId,
  }) {
    return FeedModel(
      name: name,
      weight: weight,
      observation: observation,
      id: 0,
      petId: petId,
    );
  }

  factory FeedModel.fromMap(Map<String, dynamic> map) {
    return FeedModel(
      id: map['id'] as int,
      name: map['name'] as String,
      weight: map['weight'] as num,
      observation: map['observation'] as String,
      petId: map['petId'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'weight': weight,
      'observation': observation,
      'petId': petId,
    };
  }
}
