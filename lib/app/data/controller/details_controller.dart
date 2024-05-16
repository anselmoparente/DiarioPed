import 'dart:convert';
import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:diarioped/app/data/models/meal_model.dart';

class DetailsController {
  final String id;

  DetailsController({required this.id});

  List<MealModel> meals = [];

  Future<bool> getMeals() async {
    try {
      meals.clear();

      final reference = FirebaseDatabase.instance.ref().child(
            'patients/$id',
          );

      final snapshot = await reference.get();
      var data = jsonEncode(snapshot.value);
      Map<String, dynamic> map = jsonDecode(data);

      if (map['meals'] == null) {
        meals = [];
      } else {
        map['meals'].forEach((element) {
          DateTime date = DateTime.parse(element['date']);
          Map<String, dynamic> foods = element['foods'];
          List<String> warnings = element['meals'] ?? [];
          meals.add(MealModel(foods: foods, date: date, warnings: warnings));
        });
      }
      return true;
    } catch (e) {
      log(e.toString());
      meals = [];
      return false;
    }
  }

  Future<void> sendWarnings() async {
    final reference = FirebaseDatabase.instance.ref().child(
          'patients/$id',
        );

    await reference.update({
      'meals': [
        for (MealModel meal in meals)
          {
            'foods': meal.foods,
            'date': meal.date,
            'warnings': meal.warnings,
          },
      ],
    });
  }
}
