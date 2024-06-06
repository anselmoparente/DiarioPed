import 'package:diarioped/app/ui/theme/design_system.dart';
import 'package:diarioped/app/ui/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AlertDelete extends StatelessWidget {
  const AlertDelete({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      insetPadding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
      titlePadding: EdgeInsets.zero,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 40.0,
      ),
      actionsPadding: const EdgeInsets.symmetric(horizontal: 20.0),
      title: Container(
        height: size.height * 0.085,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: DiariopedColors.button,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: const Text('Confirmar exclusão'),
      ),
      content: SizedBox(
        width: size.width * 0.9,
        child: const Text(
          'Aqui, você pode excluir a sua conta e todos os seus dados associados. Tem certeza que deseja prosseguir com a exclusão da sua conta?',
          textAlign: TextAlign.center,
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(bottom: 40.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomButton(
                backgroundColor: Colors.white,
                borderColor: DiariopedColors.button,
                text: 'Cancelar',
                textColor: DiariopedColors.button,
                onPressed: () => GoRouter.of(context).pop(),
              ),
              CustomButton(
                text: 'Excluir',
                onPressed: () => GoRouter.of(context).pop(true),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
