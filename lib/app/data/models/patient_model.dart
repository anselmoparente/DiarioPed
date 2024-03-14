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

  @override
  String toString() {
    return 'PatientModel{id: $id, nome: $name, nascimento: $birthday, meals: $meals}';
  }
}
