class PatientModel {
  final String id;
  final String email;
  final String name;
  final String relationship;

  PatientModel({
    required this.id,
    required this.email,
    required this.name,
    required this.relationship,
  });

  @override
  String toString() {
    return 'PatientModel{id: $id, email: $email, nome: $name, parentesco $relationship}';
  }
}
