import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nutriped/app/data/controller/link_controller.dart';
import 'package:nutriped/app/ui/theme/design_system.dart';
import 'package:nutriped/app/ui/widgets/custom_button.dart';
import 'package:nutriped/app/ui/widgets/custom_snackbar.dart';

class LinkPage extends StatefulWidget {
  const LinkPage({super.key});

  @override
  State<LinkPage> createState() => _LinkPageState();
}

class _LinkPageState extends State<LinkPage> {
  TextEditingController name = TextEditingController();
  TextEditingController birthday = TextEditingController();
  TextEditingController linkID =
      TextEditingController(text: 'Kb0T73mIHAcGDz8VWpU9AMc90GJ2');
  DateTime? selectedDate;

  final LinkController _controller = LinkController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.deepPurple[50],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leadingWidth: 110.0,
        leading: Center(
          child: GestureDetector(
            onTap: () => GoRouter.of(context).pop(),
            child: const Text(
              'Cancelar',
              style: TextStyle(fontSize: 18.0, color: NutripedColors.button),
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: size.width * 0.9,
              margin: const EdgeInsets.only(top: 16.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(14.0)),
              ),
              child: Column(
                children: [
                  CupertinoTextFormFieldRow(
                    controller: name,
                    prefix: const Text(
                      'Nome Completo',
                      style: TextStyle(color: Colors.grey),
                    ),
                    onChanged: (String value) => name.text = value,
                  ),
                  const Divider(height: 2.0, thickness: 1.0),
                  CupertinoTextFormFieldRow(
                    controller: birthday,
                    prefix: const Text(
                      'Data de Nascimento',
                      style: TextStyle(color: Colors.grey),
                    ),
                    readOnly: true,
                    onTap: () async {
                      final datePick = await showDatePicker(
                        context: context,
                        initialDate: selectedDate ?? DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );
      
                      if (datePick != null) {
                        selectedDate = datePick;
                        String day = datePick.day.toString().padLeft(2, '0');
                        String month =
                            datePick.month.toString().padLeft(2, '0');
                        String year = datePick.year.toString();
                        birthday.text = "$day/$month/$year";
                      }
                    },
                  ),
                  const Divider(height: 2.0, thickness: 1.0),
                  CupertinoTextFormFieldRow(
                    controller: linkID,
                    prefix: const Text(
                      'Link',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              width: size.width * 0.9,
              child: AnimatedBuilder(
                animation: _controller.isLoading$,
                builder: (context, child) {
                  return CustomButton(
                    text: 'Vincular',
                    isLoading: _controller.isLoading,
                    onPressed: () async {
                      if (name.text.length > 8 && birthday.text.isNotEmpty) {
                        await _controller
                            .linkPatient(
                          name: name.text,
                          birthday: birthday.text,
                          link: linkID.text,
                        )
                            .then(
                          (value) {
                            if (value.$1) {
                              GoRouter.of(context).pushReplacementNamed(
                                '/patient',
                              );
                              CustomSnackBar(context).show(
                                message: 'Vinculação finalizada com sucesso!',
                              );
                            } else {
                              CustomSnackBar(context).show(message: value.$2!);
                            }
                          },
                        );
                      } else {
                        CustomSnackBar(context).show(
                          message:
                              'Por favor, verifique suas informações pessoais e garanta que seu nome completo e data de nascimento estejam corretamente inseridos, pois são obrigatórios.',
                        );
                      }
                    },
                  );
                },
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
          ],
        ),
      ),
    );
  }
}
