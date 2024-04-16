import 'package:flutter/material.dart';
import 'package:nutriped/app/data/controller/details_controller.dart';
import 'package:nutriped/app/data/models/patient_model.dart';
import 'package:nutriped/app/ui/theme/design_system.dart';
import 'package:nutriped/app/ui/widgets/food_item.dart';

class DetailsPatient extends StatelessWidget {
  final DetailsController controller = DetailsController();
  final PatientModel patient;

  DetailsPatient({
    required this.patient,
    super.key,
  });

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
          'Detalhes',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: FutureBuilder(
        future: controller.getMeals(id: patient.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: NutripedColors.primary5,
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
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text: '  ${patient.birthday}',
                          style: const TextStyle(
                            fontSize: 14.0,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF99AABB),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    itemCount: controller.meals.length,
                    itemBuilder: (BuildContext context, int index) {
                      List<Widget> widgets = [];
                      DateTime date = controller.meals[index].date;
                      Map<String, dynamic> foods =
                          controller.meals[index].foods;

                      for (int i = 0; i < foods.length; i++) {
                        String title = foods.keys.elementAt(i);
                        String description = foods.values.elementAt(i);
                        widgets.add(
                          FoodItem(title: title, description: description),
                        );

                        if (i < (foods.length - 1)) {
                          widgets.add(const Divider(indent: 16.0));
                        }
                      }

                      return Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
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
