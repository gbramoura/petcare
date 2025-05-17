class ToursModel {
  final int id;
  final String activity;
  final String place;
  final DateTime date;
  final String observation;
  final int petId;

  ToursModel({
    required this.id,
    required this.activity,
    required this.place,
    required this.date,
    required this.observation,
    required this.petId,
  });

  factory ToursModel.create({
    required String activity,
    required String place,
    required DateTime date,
    required String observation,
    required int petId,
  }) {
    return ToursModel(
      activity: activity,
      place: place,
      date: date,
      observation: observation,
      id: 0,
      petId: petId,
    );
  }

  factory ToursModel.fromMap(Map<String, dynamic> map) {
    return ToursModel(
      id: map['id'] as int,
      activity: map['activity'] as String,
      place: map['place'] as String,
      date: DateTime.parse(map['date'] as String),
      observation: map['observation'] as String,
      petId: map['petId'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'activity': activity,
      'place': place,
      'date': date.toIso8601String(),
      'observation': observation,
      'petId': petId,
    };
  }
}
