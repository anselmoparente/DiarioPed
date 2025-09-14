import 'package:flutter/material.dart';
import 'package:diarioped/app/data/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

        final SharedPreferences prefs = await SharedPreferences.getInstance();

        await prefs.setString('email', email);
        await prefs.setString('pass', password);

        isLoading$.value = false;

        return (true, null);
      } catch (e) {
        if (e is AuthException) {
          isLoading$.value = false;
          return (false, e.message);
        }

        isLoading$.value = false;
        return (false, 'Não foi possivel conectar!');
      }
    } else {
      isLoading$.value = false;
      return (false, 'Credenciais inválidas!');
    }
  }

  Future<(bool, String?)> resetPassword({
    required String email,
    required AuthService auth,
  }) async {
    try {
      final response = await auth.resetPassword(email: email);
      return (true, response);
    } catch (e) {
      if (e is AuthException) {
        return (false, e.message);
      }
      return (false, 'Não foi possível redefinir a senha.');
    }
  }
}
