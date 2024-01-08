class DoctorModel {
  final String id;
  final String email;
  final String name;

  DoctorModel({
    required this.id,
    required this.email,
    required this.name,
  });

  @override
  String toString() {
    return 'DoctorModel{id: $id, email: $email, name: $name}';
  }
}
