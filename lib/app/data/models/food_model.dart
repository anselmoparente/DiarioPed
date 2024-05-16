import 'package:diarioped/app/data/constants.dart';

class FoodModel {
  final String name;
  final SugarType? sugarType;
  final Filling? fillingType;
  final Diet? dietType;

  FoodModel({
    required this.name,
    this.sugarType,
    this.fillingType,
    this.dietType,
  });

  FoodModel.fromMap(Map<String, dynamic> map)
      : name = map['name'] is String ? map['name'] as String : '',
        sugarType = map['sugarType'] is SugarType
            ? map['sugarType'] as SugarType
            : null,
        fillingType = map['fillingType'] is Filling
            ? map['fillingType'] as Filling
            : null,
        dietType = map['dietType'] is Diet ? map['dietType'] as Diet : null;

  @override
  String toString() {
    return 'FoodModel{name: $name, sugar: $sugarType, filling: $fillingType, diet: $dietType}';
  }
}
