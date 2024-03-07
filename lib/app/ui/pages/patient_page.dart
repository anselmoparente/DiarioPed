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
          'DashBoard',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
