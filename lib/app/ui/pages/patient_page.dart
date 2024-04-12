import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nutriped/app/data/controller/patient_controller.dart';

import 'package:nutriped/app/data/services/auth_service.dart';
import 'package:nutriped/app/ui/theme/design_system.dart';
import 'package:provider/provider.dart';

class PatientPage extends StatefulWidget {
  const PatientPage({super.key});

  @override
  State<PatientPage> createState() => _PatientPageState();
}

class _PatientPageState extends State<PatientPage> {
  PatientController controller = PatientController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: NutripedColors.backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: NutripedColors.button,
        leading: IconButton(
          icon: const Icon(Icons.logout),
          color: Colors.white,
          onPressed: () async {
            await context.read<AuthService>().logout().then(
                  (value) =>
                      GoRouter.of(context).pushReplacementNamed('/access'),
                );
          },
        ),
        title: const Text(
          'Diário',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            color: Colors.white,
            icon: const Icon(Icons.person),
            onPressed: () {},
          ),
        ],
      ),
      body: FutureBuilder(
        future: controller.getMeals(),
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
                        'No momento, ainda não existe nenhum paciente vinculado!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18.0, color: NutripedColors.text),
                      ),
                    )
                  ],
                ),
              ),
            );
          }

          return RawScrollbar(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            crossAxisMargin: 4.0,
            radius: const Radius.circular(20.0),
            thumbColor: Colors.grey,
            child: GridView.count(
              crossAxisCount: 2,
              children: List.generate(controller.meals.length, (index) {
                DateTime date = controller.meals[index].date;

                return Container(
                  margin: const EdgeInsets.all(16.0),
                  decoration: const BoxDecoration(
                    color: NutripedColors.primary1,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                        Text(
                          '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => GoRouter.of(context).pushNamed('/add_meal'),
      ),
    );
  }
}
