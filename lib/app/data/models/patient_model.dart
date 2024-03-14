class PatientModel {
  final String id;
  final String name;
  final String birthday;
  final List? meals;

  PatientModel({
    required this.id,
    required this.name,
    required this.birthday,
    this.meals,
  });

  PatientModel.fromMap(Map<String, dynamic> map)
      : id = map['id'] is String ? map['id'] as String : '',
        name = map['name'] is String ? map['name'] as String : '',
        birthday = map['birthday'] is String ? map['birthday'] as String : '',
        meals = map['meals'] is List ? map['meals'] as List : [];

  @override
  String toString() {
    return 'PatientModel{id: $id, nome: $name, nascimento: $birthday, meals: $meals}';
  }
}
