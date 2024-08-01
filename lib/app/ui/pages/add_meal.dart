import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:diarioped/app/data/constants.dart';
import 'package:diarioped/app/data/controller/patient_controller.dart';
import 'package:diarioped/app/data/models/food_model.dart';
import 'package:diarioped/app/ui/theme/design_system.dart';
import 'package:diarioped/app/ui/widgets/custom_button.dart';
import 'package:diarioped/app/ui/widgets/custom_snackbar.dart';
import 'package:diarioped/app/ui/widgets/custom_text_form_field.dart';

class AddMeal extends StatefulWidget {
  const AddMeal({super.key});

  @override
  State<AddMeal> createState() => _AddMealState();
}

class _AddMealState extends State<AddMeal> {
  PatientController controller = PatientController();
  TextEditingController meal = TextEditingController();
  TextEditingController mealDialog = TextEditingController();
  TextEditingController descriptionDialog = TextEditingController();

  String? selectedFood;
  SugarType? sugarType;
  Filling? fillingType;
  Diet? dietType;

  List<String> aux = [];

  void search(String search) {
    aux = foodsList
        .where((element) => element.toLowerCase().contains(search))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    void showAddMealDialog(BuildContext context) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            actionsAlignment: MainAxisAlignment.spaceBetween,
            title: const Text('Adicionar Alimento'),
            content: IntrinsicHeight(
              child: Column(
                children: [
                  CustomTextFormField(
                    controller: mealDialog,
                    hint: 'Alimento (Ex: Café com leite)',
                    label: 'Alimento',
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  mealDialog.clear();
                  descriptionDialog.clear();
                  Navigator.of(context).pop();
                },
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: () {
                  String food = mealDialog.text;

                  if (food.isNotEmpty) {
                    if (!controller.meal.contains(food)) {
                      setState(() {
                        controller.meal.add(FoodModel(name: food));
                        meal.clear();
                        search('');
                        selectedFood = null;
                      });
                    } else {
                      CustomSnackBar(context).show(
                        message: 'Você já adicionou esse alimento!',
                      );
                    }

                    mealDialog.clear();
                    descriptionDialog.clear();
                    Navigator.of(context).pop();
                  }
                },
                child: const Text('Adicionar'),
              ),
            ],
          );
        },
      );
    }

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
          'Adicionar refeição',
          style: TextStyle(color: DiariopedColors.background),
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
                      color: DiariopedColors.itemBackGround,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: ListView.separated(
                      itemCount: controller.meal.length,
                      separatorBuilder: (context, index) {
                        return const Divider(
                          color: Colors.grey,
                        );
                      },
                      itemBuilder: (context, index) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IntrinsicHeight(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    controller.meal[index].name,
                                    style: const TextStyle(fontSize: 16.0),
                                  ),
                                  Visibility(
                                    maintainSize: false,
                                    visible: controller.meal[index].sugarType !=
                                        null,
                                    child: controller.meal[index].sugarType !=
                                            null
                                        ? Container(
                                            padding:
                                                const EdgeInsets.only(top: 4.0),
                                            child: Text(
                                              controller
                                                  .meal[index].sugarType!.value,
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
                                        controller.meal[index].fillingType !=
                                            null,
                                    child: controller.meal[index].fillingType !=
                                            null
                                        ? Container(
                                            padding:
                                                const EdgeInsets.only(top: 4.0),
                                            child: Text(
                                              controller.meal[index]
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
                                    visible:
                                        controller.meal[index].dietType != null,
                                    child: controller.meal[index].dietType !=
                                            null
                                        ? Container(
                                            padding:
                                                const EdgeInsets.only(top: 4.0),
                                            child: Text(
                                              controller
                                                  .meal[index].dietType!.value,
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
                                () => controller.meal.removeAt(index),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                Material(
                  elevation: 3.0,
                  borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                  child: IntrinsicHeight(
                    child: Container(
                      width: size.width * 0.9,
                      padding: const EdgeInsets.all(8.0),
                      decoration: const BoxDecoration(
                        color: DiariopedColors.itemBackGround,
                        borderRadius: BorderRadius.all(Radius.circular(16.0)),
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
                              itemCount: meal.text.isEmpty
                                  ? foodsList.length
                                  : aux.length,
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
                                              ? foodsList[index] == selectedFood
                                                  ? DiariopedColors.button
                                                  : Colors.white
                                              : aux[index] == selectedFood
                                                  ? DiariopedColors.button
                                                  : Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        child: Center(
                                          child: Text(
                                            meal.text.isEmpty
                                                ? foodsList[index]
                                                : aux[index],
                                            style: TextStyle(
                                              color: (meal.text.isEmpty)
                                                  ? foodsList[index] ==
                                                          selectedFood
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
                                      if (selectedFood != foodsList[index]) {
                                        selectedFood = foodsList[index];
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
                                      activeColor: DiariopedColors.secondary,
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
                                      activeColor: DiariopedColors.secondary,
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
                                      activeColor: DiariopedColors.secondary,
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
                              backgroundColor: DiariopedColors.primary1,
                              text: 'Adicionar alimento',
                              onPressed: () {
                                if (selectedFood != null) {
                                  if (!controller.meal.contains(selectedFood)) {
                                    setState(() {
                                      controller.meal.add(
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
                              borderColor: DiariopedColors.primary1,
                              textColor: DiariopedColors.primary1,
                              text: 'Adicionar manualmente',
                              onPressed: () => showAddMealDialog(context),
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
                    backgroundColor: DiariopedColors.button,
                    text: 'Finalizar refeição',
                    onPressed: () async {
                      if (controller.meal.isEmpty) {
                        CustomSnackBar(context).show(
                          message: 'Inclua os alimentos que foram consumidos.',
                        );
                      } else {
                        await controller
                            .showDateTimePicker(context: context)
                            .then(
                          (value) async {
                            if (value != null) {
                              await controller
                                  .sendMeal(
                                time: value,
                              )
                                  .then(
                                (value) {
                                  if (value) {
                                    CustomSnackBar(context).show(
                                      message:
                                          'Refeição adicionada com sucesso!',
                                    );
                                    GoRouter.of(context).pop();
                                  } else {
                                    CustomSnackBar(context).show(
                                      message: 'Falha ao adicionar refeição!',
                                    );
                                  }
                                },
                              );
                            } else {
                              CustomSnackBar(context).show(
                                message:
                                    'Por favor, insira um horário válido para indicar quando o alimento foi consumido.',
                              );
                            }
                          },
                        );
                      }
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
