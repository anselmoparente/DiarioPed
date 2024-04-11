class MealModel {
  final Map<String, String> foods;
  final DateTime date;

  MealModel({required this.foods, required this.date});

  @override
  String toString() {
    return 'MealModel{foods: $foods, date: $date}';
  }
}
