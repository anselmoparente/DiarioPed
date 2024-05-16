import 'package:flutter/material.dart';
import 'package:diarioped/app/data/controller/details_controller.dart';
import 'package:diarioped/app/data/models/meal_model.dart';
import 'package:diarioped/app/data/models/patient_model.dart';
import 'package:diarioped/app/ui/theme/design_system.dart';
import 'package:diarioped/app/ui/widgets/food_item.dart';

class DetailsPatient extends StatefulWidget {
  final PatientModel patient;
  late final DetailsController controller;

  DetailsPatient({
    required this.patient,
    super.key,
  }) {
    controller = DetailsController(id: patient.id);
  }

  @override
  State<DetailsPatient> createState() => _DetailsPatientState();
}

class _DetailsPatientState extends State<DetailsPatient> {
  late Future<bool> _isCharge;

  @override
  void initState() {
    super.initState();
    _isCharge = widget.controller.getMeals();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: DiariopedColors.background,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: DiariopedColors.button,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: DiariopedColors.background,
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Detalhes',
          style: TextStyle(
            color: DiariopedColors.background,
            fontWeight: FontWeight.bold,
            fontSize: 24.0,
          ),
        ),
      ),
      body: FutureBuilder(
        future: _isCharge,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          }

          if (widget.controller.meals.isEmpty) {
            Center(
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    const Icon(
                      Icons.group_off,
                      size: 108.0,
                      color: DiariopedColors.icon,
                    ),
                    const SizedBox(height: 16.0),
                    SizedBox(
                      width: size.width * 0.8,
                      child: const Text(
                        'Por enquanto, não há nenhuma refeição cadastrada.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18.0,
                          color: DiariopedColors.text,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IntrinsicHeight(
                  child: RichText(
                    overflow: TextOverflow.visible,
                    text: TextSpan(
                      text: widget.patient.name,
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                      children: [
                        TextSpan(
                          text: '  ${widget.patient.birthday}',
                          style: const TextStyle(
                            fontSize: 14.0,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8.0),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    itemCount: widget.controller.meals.length,
                    itemBuilder: (BuildContext context, int index) {
                      List<Widget> widgets = [];
                      DateTime date = widget.controller.meals[index].date;
                      Map<String, dynamic> foods =
                          widget.controller.meals[index].foods;
                      List<String> warnings =
                          widget.controller.meals[index].warnings;

                      for (int i = 0; i < foods.length; i++) {
                        String title = foods.keys.elementAt(i);
                        String description = foods.values.elementAt(i);
                        widgets.add(
                          FoodItem(
                            title: title,
                            description: description,
                            isWarning: warnings.contains(title),
                          ),
                        );

                        if (i < (foods.length - 1)) {
                          widgets.add(const Divider(indent: 16.0));
                        }
                      }

                      return GestureDetector(
                        onDoubleTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text(
                                  'Marque os alimentos que apresentam algum risco',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                content: SizedBox(
                                  height: size.height * 0.5,
                                  child: CheckboxList(
                                    meals: widget.controller.meals,
                                    indexMeal: index,
                                  ),
                                ),
                                actions: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Cancelar'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          setState(() {});
                                        },
                                        child: const Text('Confirmar'),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(16.0),
                          margin: EdgeInsets.only(top: index != 0 ? 16.0 : 0.0),
                          decoration: BoxDecoration(
                            color: DiariopedColors.itemBackGround,
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: IntrinsicHeight(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}',
                                    ),
                                    Text(
                                      '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}',
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8.0),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: widgets,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class CheckboxList extends StatefulWidget {
  final List<MealModel> meals;
  final int indexMeal;

  const CheckboxList({
    super.key,
    required this.meals,
    required this.indexMeal,
  });

  @override
  State<CheckboxList> createState() => _CheckboxListState();
}

class _CheckboxListState extends State<CheckboxList> {
  @override
  Widget build(BuildContext context) {
    MealModel meal = widget.meals[widget.indexMeal];
    return ListView.builder(
      itemCount: meal.foods.length,
      itemBuilder: (BuildContext context, int index) {
        return CheckboxListTile(
          title: Text(meal.foods.keys.elementAt(index)),
          value: meal.warnings.contains(meal.foods.keys.elementAt(index)),
          onChanged: (bool? value) {
            setState(
              () {
                if (meal.warnings.contains(meal.foods.keys.elementAt(index))) {
                  meal.warnings.remove(meal.foods.keys.elementAt(index));
                } else {
                  meal.warnings.add(meal.foods.keys.elementAt(index));
                }
              },
            );
          },
        );
      },
    );
  }
}
