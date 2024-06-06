import 'package:diarioped/app/ui/widgets/alert_delete_account.dart';
import 'package:diarioped/app/ui/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:diarioped/app/data/controller/dashboard_controller.dart';
import 'package:diarioped/app/data/services/auth_service.dart';
import 'package:diarioped/app/ui/theme/design_system.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final DashboardController controller = DashboardController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    void copyToClipboard({required String textToCopy}) {
      Clipboard.setData(ClipboardData(text: textToCopy));
      CustomSnackBar(context).show(
        message: 'Código copiado para a área de transferência',
      );
    }

    return Scaffold(
      backgroundColor: DiariopedColors.background,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: DiariopedColors.button,
        leading: PopupMenuButton(
          color: DiariopedColors.cardBackground,
          padding: EdgeInsets.zero,
          constraints: BoxConstraints(
            minWidth: size.width * 0.4,
            minHeight: size.height * 0.13,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(24.0),
              bottomLeft: Radius.circular(24.0),
              bottomRight: Radius.circular(24.0),
            ),
          ),
          child: const Icon(
            Icons.menu,
            color: DiariopedColors.background,
          ),
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            const PopupMenuItem<String>(
              value: 'logout',
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    'Sair',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            const PopupMenuItem<String>(
              value: 'delete',
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    'Excluir conta',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
          onSelected: (String value) async {
            if (value == 'logout') {
              await context.read<AuthService>().logout().then(
                    (value) =>
                        GoRouter.of(context).pushReplacementNamed('/access'),
                  );
            } else if (value == 'delete') {
              showDialog(
                context: context,
                builder: (BuildContext context) => const AlertDelete(),
              ).then(
                (value) async => await context
                    .read<AuthService>()
                    .logout()
                    .then(
                      (value) =>
                          GoRouter.of(context).pushReplacementNamed('/access'),
                    ),
              );
            }
          },
        ),
        title: const Text(
          'DashBoard',
          style: TextStyle(color: DiariopedColors.background),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.link,
              color: DiariopedColors.background,
            ),
            onPressed: () {
              String link = controller.getLink(
                auth: context.read<AuthService>(),
              );

              copyToClipboard(textToCopy: link);
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: controller.getPatients(auth: context.read<AuthService>()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
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
                      color: DiariopedColors.icon,
                    ),
                    const SizedBox(height: 16.0),
                    SizedBox(
                      width: size.width * 0.8,
                      child: const Text(
                        'No momento, ainda não existe nenhum paciente vinculado!',
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

          return RawScrollbar(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            crossAxisMargin: 4.0,
            radius: const Radius.circular(20.0),
            thumbColor: Colors.grey,
            child: GridView.count(
              crossAxisCount: 2,
              children: List.generate(
                controller.patients.length,
                (index) {
                  return GestureDetector(
                    child: Container(
                      margin: const EdgeInsets.all(16.0),
                      decoration: const BoxDecoration(
                        color: DiariopedColors.cardBackground,
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
                              controller.patients[index].name,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                            Text(
                              controller.patients[index].birthday,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    onTap: () => GoRouter.of(context).pushNamed(
                      '/details_patient',
                      extra: controller.patients[index],
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
