import 'package:flutter/material.dart';
import 'package:nutriped/app/data/constants.dart';
import 'package:nutriped/app/data/controller/patient_controller.dart';
import 'package:nutriped/app/data/models/food_model.dart';
import 'package:nutriped/app/ui/theme/design_system.dart';
import 'package:nutriped/app/ui/widgets/custom_button.dart';
import 'package:nutriped/app/ui/widgets/custom_snackbar.dart';
import 'package:nutriped/app/ui/widgets/custom_text_form_field.dart';

class AddMeal extends StatefulWidget {
  const AddMeal({super.key});

  @override
  State<AddMeal> createState() => _AddMealState();
}

class _AddMealState extends State<AddMeal> {
  PatientController controller = PatientController();
  TextEditingController meal = TextEditingController();

  String? selectedFood;
  SugarType? sugarType;
  Filling? fillingType;
  Diet? dietType;

  List<String> aux = [];

  void search(String search) {
    aux = foods.where((element) => element.toLowerCase().contains(search)).toList();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: NutripedColors.backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: NutripedColors.button,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.white,
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Adicionar refeição',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: size.width,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Material(
                  elevation: 3.0,
                  borderRadius: BorderRadius.circular(16.0),
                  child: Container(
                    height: size.height * 0.35,
                    width: size.width * 0.9,
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: ListView.separated(
                      itemCount: controller.meals.length,
                      itemBuilder: (context, index) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IntrinsicHeight(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    controller.meals[index].name,
                                    style: const TextStyle(fontSize: 16.0),
                                  ),
                                  Visibility(
                                    maintainSize: false,
                                    visible:
                                        controller.meals[index].sugarType !=
                                            null,
                                    child: controller.meals[index].sugarType !=
                                            null
                                        ? Container(
                                            padding:
                                                const EdgeInsets.only(top: 4.0),
                                            child: Text(
                                              controller.meals[index].sugarType!
                                                  .value,
                                              style: const TextStyle(
                                                color: Colors.grey,
                                                fontSize: 14.0,
                                              ),
                                            ),
                                          )
                                        : const SizedBox(),
                                  ),
                                  Visibility(
                                    maintainSize: false,
                                    visible:
                                        controller.meals[index].fillingType !=
                                            null,
                                    child: controller
                                                .meals[index].fillingType !=
                                            null
                                        ? Container(
                                            padding:
                                                const EdgeInsets.only(top: 4.0),
                                            child: Text(
                                              controller.meals[index]
                                                  .fillingType!.value,
                                              style: const TextStyle(
                                                color: Colors.grey,
                                                fontSize: 14.0,
                                              ),
                                            ),
                                          )
                                        : const SizedBox(),
                                  ),
                                  Visibility(
                                    maintainSize: false,
                                    visible: controller.meals[index].dietType !=
                                        null,
                                    child: controller.meals[index].dietType !=
                                            null
                                        ? Container(
                                            padding:
                                                const EdgeInsets.only(top: 4.0),
                                            child: Text(
                                              controller
                                                  .meals[index].dietType!.value,
                                              style: const TextStyle(
                                                color: Colors.grey,
                                                fontSize: 14.0,
                                              ),
                                            ),
                                          )
                                        : const SizedBox(),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              color: Colors.red,
                              onPressed: () => setState(
                                () => controller.meals.removeAt(index),
                              ),
                            ),
                          ],
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider(
                          color: Colors.grey,
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                Material(
                  elevation: 3.0,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0),
                  ),
                  child: IntrinsicHeight(
                    child: Container(
                      width: size.width * 0.9,
                      padding: const EdgeInsets.all(8.0),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16.0),
                          topRight: Radius.circular(16.0),
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: size.width * 0.7,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16.0),
                                    color: Colors.black.withOpacity(0.05),
                                  ),
                                  child: CustomTextFormField(
                                    controller: meal,
                                    label: 'Pesquisar',
                                    noHaveLabel: true,
                                    onChanged: (String text) => setState(
                                      () => search(text),
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.cancel,
                                  color: Colors.grey,
                                  size: 32.0,
                                ),
                                onPressed: () => setState(() {
                                  meal.clear();
                                  search('');
                                }),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16.0),
                          SizedBox(
                            height: size.height * 0.06,
                            width: size.width - 16.0,
                            child: ListView.builder(
                              padding: const EdgeInsets.all(4.0),
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  meal.text.isEmpty ? foods.length : aux.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  child: Container(
                                    margin: EdgeInsets.only(
                                      left: index != 0 ? 8.0 : 0.0,
                                    ),
                                    child: Material(
                                      elevation: 1.0,
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0,
                                        ),
                                        decoration: BoxDecoration(
                                          color: (meal.text.isEmpty)
                                              ? foods[index] == selectedFood
                                                  ? NutripedColors.button
                                                  : Colors.yellow
                                              : aux[index] == selectedFood
                                                  ? NutripedColors.button
                                                  : Colors.yellow,
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        child: Center(
                                          child: Text(
                                            meal.text.isEmpty
                                                ? foods[index]
                                                : aux[index],
                                            style: TextStyle(
                                              color: (meal.text.isEmpty)
                                                  ? foods[index] == selectedFood
                                                      ? Colors.white
                                                      : Colors.black
                                                  : aux[index] == selectedFood
                                                      ? Colors.white
                                                      : Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  onTap: () => setState(() {
                                    if (meal.text.isEmpty) {
                                      if (selectedFood != foods[index]) {
                                        selectedFood = foods[index];
                                        sugarType = null;
                                        fillingType = null;
                                        dietType = null;
                                      }
                                    } else {
                                      if (selectedFood != aux[index]) {
                                        selectedFood = aux[index];
                                        sugarType = null;
                                        fillingType = null;
                                        dietType = null;
                                      }
                                    }
                                  }),
                                );
                              },
                            ),
                          ),
                          Visibility(
                            visible: sugar.contains(selectedFood),
                            child: Container(
                              margin: const EdgeInsets.only(top: 16.0),
                              child: IntrinsicHeight(
                                child: Column(
                                  children: SugarType.values.map((type) {
                                    return RadioListTile<SugarType>(
                                      title: Text(type.value),
                                      value: type,
                                      groupValue: sugarType,
                                      onChanged: (value) => setState(
                                        () => sugarType = value,
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: filling.contains(selectedFood),
                            child: Container(
                              margin: const EdgeInsets.only(top: 16.0),
                              child: IntrinsicHeight(
                                child: Column(
                                  children: Filling.values.map((type) {
                                    return RadioListTile<Filling>(
                                      title: Text(type.value),
                                      value: type,
                                      groupValue: fillingType,
                                      onChanged: (value) => setState(
                                        () => fillingType = value,
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: diet.contains(selectedFood),
                            child: Container(
                              margin: const EdgeInsets.only(top: 16.0),
                              child: IntrinsicHeight(
                                child: Column(
                                  children: Diet.values.map((type) {
                                    return RadioListTile<Diet>(
                                      title: Text(type.value),
                                      value: type,
                                      groupValue: dietType,
                                      onChanged: (value) => setState(
                                        () => dietType = value,
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          SizedBox(
                            width: size.width * 0.7,
                            child: CustomButton(
                              backgroundColor: NutripedColors.primary1,
                              text: 'Adicionar alimento',
                              onPressed: () {
                                if (selectedFood != null) {
                                  if (!controller.meals
                                      .contains(selectedFood)) {
                                    setState(() {
                                      controller.meals.add(
                                        FoodModel(
                                          name: selectedFood!,
                                          sugarType: sugarType,
                                          fillingType: fillingType,
                                          dietType: dietType,
                                        ),
                                      );
                                      meal.clear();
                                      search('');
                                      selectedFood = null;
                                    });
                                  } else {
                                    CustomSnackBar(context).show(
                                      message:
                                          'Você já adicionou esse alimento!',
                                    );
                                  }
                                }
                              },
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          SizedBox(
                            width: size.width * 0.7,
                            child: CustomButton(
                              backgroundColor: Colors.white,
                              borderColor: NutripedColors.primary1,
                              textColor: NutripedColors.primary1,
                              text: 'Adicionar manualmente',
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                SizedBox(
                  width: size.width * 0.9,
                  child: CustomButton(
                    backgroundColor: NutripedColors.button,
                    text: 'Finalizar refeição',
                    onPressed: () async {
                      await controller.showDateTimePicker(context: context);
                    },
                  ),
                ),
                const SizedBox(height: 20.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
