import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nutriped/app/data/controller/dashboard_controller.dart';
import 'package:nutriped/app/data/services/auth_service.dart';
import 'package:nutriped/app/ui/theme/design_system.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final DashboardController controller = DashboardController();

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
          'DashBoard',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.person,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: FutureBuilder(
        future: controller.getPatients(auth: context.read<AuthService>()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: NutripedColors.primary5,
              ),
            );
          }

          if (controller.patients.isEmpty) {
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
              children: List.generate(controller.patients.length, (index) {
                return Container(
                  margin: const EdgeInsets.all(16.0),
                  decoration: const BoxDecoration(
                    color: NutripedColors.primary1,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        controller.patients[index].name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          );
        },
      ),
    );
  }
}
