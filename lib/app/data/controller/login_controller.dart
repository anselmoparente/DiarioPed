import 'package:flutter/material.dart';
import 'package:nutriped/app/data/services/auth_service.dart';

class LoginController {
  var isLoading$ = ValueNotifier(false);
  bool get isLoading => isLoading$.value;

  Future<(bool, String?)> login({
    required String email,
    required String password,
    required AuthService auth,
  }) async {
    isLoading$.value = true;

    if (email.isNotEmpty && password.isNotEmpty) {
      try {
        await auth.login(email, password);

        final user = auth.user;

        print(user);
        isLoading$.value = false;

        return (true, null);
      } catch (e) {
        isLoading$.value = false;
        return (false, 'Não foi possivel conectar!');
      }
    } else {
      isLoading$.value = false;
      return (false, 'Credenciais inválidas!');
    }
  }
}
