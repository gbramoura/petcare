class PetModel {
  final int id;
  final String name;
  final String breed;
  final DateTime bornDate;
  final String observation;
  final String image;

  PetModel({
    required this.id,
    required this.name,
    required this.breed,
    required this.bornDate,
    required this.observation,
    required this.image,
  });

  factory PetModel.create({
    required int id,
    required String name,
    required String breed,
    required DateTime bornDate,
    required String observation,
    required String image,
  }) {
    return PetModel(
      name: name,
      breed: breed,
      bornDate: bornDate,
      observation: observation,
      image: image,
      id: id,
    );
  }

  factory PetModel.fromMap(Map<String, dynamic> map) {
    return PetModel(
      id: map['id'] as int,
      name: map['name'] as String,
      breed: map['breed'] as String,
      bornDate: DateTime.parse(map['bornDate'] as String),
      observation: map['observation'] as String,
      image: map['image'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'breed': breed,
      'bornDate': bornDate.toIso8601String(),
      'observation': observation,
      'image': image,
    };
  }

  static String getCreateTableQuery() {
    return '''
      CREATE TABLE IF NOT EXISTS pets  (
        id INTEGER AUTO_INCREMENT,
        name TEXT NOT NULL,
        breed TEXT NOT NULL,
        bornDate TEXT NOT NULL,
        observation TEXT,
        image TEXT NOT NULL,
  		  PRIMARY KEY(id)
      );
    ''';
  }
}
