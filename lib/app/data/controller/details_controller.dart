import 'dart:convert';
import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:nutriped/app/data/models/meal_model.dart';

class DetailsController {
  List<MealModel> meals = [];

  Future<void> getMeals({required String id}) async {
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
          map['meals'].forEach((element) {
            DateTime date = DateTime.parse(element['date']);
            Map<String, dynamic> aux = element['foods'];
            meals.add(MealModel(foods: aux, date: date));
          });
        });
      }

      
    } catch (e) {
      log(e.toString());
      meals = [];
    }
  }
}
