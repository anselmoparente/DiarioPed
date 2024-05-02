import 'package:flutter/material.dart';
import 'package:nutriped/app/data/controller/details_controller.dart';
import 'package:nutriped/app/data/models/patient_model.dart';
import 'package:nutriped/app/ui/theme/design_system.dart';
import 'package:nutriped/app/ui/widgets/food_item.dart';

class DetailsPatient extends StatelessWidget {
  final PatientModel patient;

  DetailsPatient({
    required this.patient,
    super.key,
  });

  final DetailsController controller = DetailsController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: NutripedColors.background,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: NutripedColors.button,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: NutripedColors.background,
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Detalhes',
          style: TextStyle(
            color: NutripedColors.background,
            fontWeight: FontWeight.bold,
            fontSize: 24.0,
          ),
        ),
      ),
      body: FutureBuilder(
        future: controller.getMeals(id: patient.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          }

          if (controller.meals.isEmpty) {
            Center(
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    const Icon(
                      Icons.group_off,
                      size: 108.0,
                      color: NutripedColors.icon,
                    ),
                    const SizedBox(height: 16.0),
                    SizedBox(
                      width: size.width * 0.8,
                      child: const Text(
                        'Por enquanto, não há nenhuma refeição cadastrada.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18.0,
                          color: NutripedColors.text,
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
                      text: patient.name,
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                      children: [
                        TextSpan(
                          text: '  ${patient.birthday}',
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
                    itemCount: controller.meals.length,
                    itemBuilder: (BuildContext context, int index) {
                      List<String> items = [];
                      List<String> checked = [];
                      List<Widget> widgets = [];
                      DateTime date = controller.meals[index].date;
                      Map<String, dynamic> foods =
                          controller.meals[index].foods;

                      for (int i = 0; i < foods.length; i++) {
                        String title = foods.keys.elementAt(i);
                        items.add(title);
                        String description = foods.values.elementAt(i);
                        widgets.add(
                          FoodItem(
                            title: title,
                            description: description,
                            isWarning: checked.contains(items[index]),
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
                                      fontWeight: FontWeight.bold),
                                ),
                                content: SizedBox(
                                  height: size.height * 0.5,
                                  child: CheckboxList(
                                    items: items,
                                    checked: checked,
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
                            color: NutripedColors.itemBackGround,
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
  final List<String> items;
  final List<String> checked;

  const CheckboxList({
    super.key,
    required this.items,
    required this.checked,
  });

  @override
  State<CheckboxList> createState() => _CheckboxListState();
}

class _CheckboxListState extends State<CheckboxList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.items.length,
      itemBuilder: (BuildContext context, int index) {
        return CheckboxListTile(
          title: Text(widget.items[index]),
          value: widget.checked.contains(widget.items[index]),
          onChanged: (bool? value) {
            setState(
              () {
                if (widget.checked.contains(widget.items[index])) {
                  widget.checked.remove(widget.items[index]);
                } else {
                  widget.checked.add(widget.items[index]);
                }
              },
            );
          },
        );
      },
    );
  }
}
