import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:diarioped/app/data/controller/register_controller.dart';
import 'package:diarioped/app/ui/widgets/custom_button.dart';
import 'package:diarioped/app/ui/widgets/custom_snackbar.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController passwordConfirmation = TextEditingController();

  final RegisterController _controller = RegisterController();

  @override
  void initState() {
    super.initState();
  }

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
              style: TextStyle(fontSize: 18.0, color: Colors.blue),
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
                    controller: email,
                    prefix: const Text(
                      'Email',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  const Divider(height: 2.0, thickness: 1.0),
                  CupertinoTextFormFieldRow(
                    controller: password,
                    obscureText: true,
                    prefix: const Text(
                      'Senha',
                      style: TextStyle(color: Colors.grey),
                    ),
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Informe sua senha';
                      } else if (value.length < 8) {
                        return 'Sua senha deve conter no mínimo 6 caracteres';
                      }
                      return null;
                    },
                  ),
                  const Divider(height: 2.0, thickness: 1.0),
                  CupertinoTextFormFieldRow(
                    controller: passwordConfirmation,
                    obscureText: true,
                    prefix: const Text(
                      'Confirmação',
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
                      text: 'Registrar',
                      isLoading: _controller.isLoading,
                      onPressed: () async {
                        await _controller
                            .register(
                          name: name.text,
                          email: email.text,
                          password: password.text,
                          passwordConfirmation: passwordConfirmation.text,
                        )
                            .then(
                          (value) {
                            if (value.$1) {
                              GoRouter.of(context)
                                  .pushReplacementNamed('/home');
                            } else {
                              CustomSnackBar(context).show(
                                message: value.$2!,
                              );
                            }
                          },
                        );
                      },
                    );
                  }),
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
