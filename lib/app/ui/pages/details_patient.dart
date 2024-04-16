import 'package:flutter/material.dart';
import 'package:nutriped/app/data/controller/details_controller.dart';
import 'package:nutriped/app/data/models/patient_model.dart';
import 'package:nutriped/app/ui/theme/design_system.dart';

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

            return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: 100,
              itemBuilder: (BuildContext context, int index) {
                return IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('$index'),
                    ],
                  ),
                );
              },
            );
          }),
    );
  }
}
