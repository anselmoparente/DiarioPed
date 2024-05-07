class MealModel {
  final Map<String, dynamic> foods;
  final List<String> warnings;
  final DateTime date;

  MealModel({required this.foods, required this.warnings, required this.date});

  @override
  String toString() {
    return 'MealModel{foods: $foods, warnings: $warnings, date: $date}';
  }
}
