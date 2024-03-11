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
  final PatientController _controller = PatientController();

  @override
  Widget build(BuildContext context) {
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
      body: RawScrollbar(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        crossAxisMargin: 4.0,
        radius: const Radius.circular(20.0),
        thumbColor: Colors.grey,
        child: GridView.count(
          crossAxisCount: 2,
          children: List.generate(9, (index) {
            return Container(
              margin: const EdgeInsets.all(16.0),
              decoration: const BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              child: Center(
                child: Text(
                  'Item ${index + 1}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            );
          }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}
