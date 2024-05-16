import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:diarioped/app/data/models/food_model.dart';
import 'package:diarioped/app/data/models/meal_model.dart';

class PatientController {
  List<FoodModel> meal = [];
  List<MealModel> meals = [];

  Future<void> getMeals({String? id}) async {
    try {
      meals.clear();

      String? deviceID;

      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      if (Platform.isAndroid) {
        var androidInfo = await deviceInfo.androidInfo;
        deviceID = androidInfo.id;
      }

      if (Platform.isIOS) {
        var iosInfo = await deviceInfo.iosInfo;
        deviceID = iosInfo.identifierForVendor!;
      }

      if (deviceID != null) {
        deviceID = deviceID.replaceAll('.', '');
      }

      final reference = FirebaseDatabase.instance.ref().child(
            'patients/$deviceID',
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
          List<String> warnings = element['warnings'] ?? [];
          MealModel meal =
              MealModel(foods: foods, date: date, warnings: warnings);
          if (!meals.contains(meal)) {
            meals.add(MealModel(foods: foods, date: date, warnings: warnings));
          }
        });
      }
    } catch (e) {
      log(e.toString());
      meals = [];
    }
  }

  Future<bool> sendMeal({required DateTime time}) async {
    try {
      String? deviceID;

      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      if (Platform.isAndroid) {
        var androidInfo = await deviceInfo.androidInfo;
        deviceID = androidInfo.id;
      }

      if (Platform.isIOS) {
        var iosInfo = await deviceInfo.iosInfo;
        deviceID = iosInfo.identifierForVendor!;
      }

      if (deviceID != null) {
        deviceID = deviceID.replaceAll('.', '');
      }

      final reference = FirebaseDatabase.instance.ref().child(
            'patients/$deviceID',
          );

      final snapshot = await reference.get();
      var data = jsonEncode(snapshot.value);
      Map<String, dynamic> map = jsonDecode(data);

      if (map['meals'] != null) {
        List<dynamic> list = map['meals'];

        Map<String, dynamic> aux = {};

        for (FoodModel item in meal) {
          aux[item.name] = item.sugarType?.value ??
              item.fillingType?.value ??
              item.dietType?.value ??
              '';
        }

        list.add(
          {
            'foods': aux,
            'date': time.toIso8601String(),
          },
        );

        reference.update({
          'meals': list,
        });
      } else {
        Map<String, dynamic> map = {};

        for (FoodModel item in meal) {
          map[item.name] = item.sugarType?.value ??
              item.fillingType?.value ??
              item.dietType?.value ??
              '';
        }

        meals.add(MealModel(foods: map, date: time, warnings: []));

        reference.update({
          'meals': [
            {
              'foods': map,
              'date': time.toIso8601String(),
            },
          ],
        });

        meal.clear();
      }

      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<DateTime?> showDateTimePicker({
    required BuildContext context,
  }) async {
    DateTime initialDate = DateTime.now();
    DateTime firstDate = initialDate.subtract(const Duration(days: 365 * 100));
    DateTime lastDate = DateTime.now();

    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      locale: Localizations.localeOf(context),
    );

    if (selectedDate == null) return null;

    if (!context.mounted) return selectedDate;

    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(selectedDate),
    );

    return selectedTime == null
        ? null
        : DateTime(
            selectedDate.year,
            selectedDate.month,
            selectedDate.day,
            selectedTime.hour,
            selectedTime.minute,
          );
  }
}
