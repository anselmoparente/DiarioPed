import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nutriped/app/data/controller/login_controller.dart';
import 'package:nutriped/app/ui/widgets/custom_button.dart';
import 'package:nutriped/app/ui/widgets/custom_text_form_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  LoginController controller = LoginController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.blue.shade900,
          onPressed: () => GoRouter.of(context).pop(),
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: size.height * 0.15,
            child: Image.asset('assets/images/splash_icon.png'),
          ),
          Container(
            margin: EdgeInsets.only(top: size.height * 0.02),
            child: Wrap(
              direction: Axis.vertical,
              spacing: 8.0,
              children: [
                Container(
                  width: size.width * 0.9,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                  child: CustomTextFormField(
                    controller: email,
                    hintText: 'Email',
                  ),
                ),
                Container(
                  width: size.width * 0.9,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                  child: CustomTextFormField(
                    controller: password,
                    hintText: 'Senha',
                    obscureText: true,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: size.height * 0.04),
            width: size.width * 0.9,
            child: AnimatedBuilder(
              animation: controller.isLoading$,
              builder: (BuildContext context, Widget? child) {
                return CustomButton(
                  text: 'Login',
                  onPressed: () {},
                );
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: size.height * 0.04),
            height: size.height * 0.07,
            width: size.width * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text(
                      'Esquece a senha?',
                      style: TextStyle(
                        fontSize: 17,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (isValidEmail(email.text)) {
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Esse email não é valido!'),
                            ),
                          );
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: size.width * 0.05),
                        child: const Text(
                          'Trocar senha',
                          style: TextStyle(
                            fontSize: 17,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      'Não possui conta?',
                      style: TextStyle(
                        fontSize: 17,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: size.width * 0.05),
                      child: GestureDetector(
                        onTap: () =>
                            GoRouter.of(context).pushNamed('/register'),
                        child: const Text(
                          'Registrar',
                          style: TextStyle(
                            fontSize: 17,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool isValidEmail(String email) {
    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    return emailRegex.hasMatch(email);
  }
}
