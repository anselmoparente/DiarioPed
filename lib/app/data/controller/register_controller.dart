import 'package:flutter/material.dart';
import 'package:nutriped/app/data/services/auth_service.dart';

class RegisterController {
  var isLoading$ = ValueNotifier(false);
  bool get isLoading => isLoading$.value;

  Future<(bool, String?)> register({
    required String email,
    required String password,
    required String passwordConfirmation,
    required AuthService auth,
  }) async {
    isLoading$.value = true;

    if (email.isNotEmpty &&
        (password.isNotEmpty && passwordConfirmation.isNotEmpty) &&
        password == passwordConfirmation) {
      try {
        isLoading$.value = false;

        auth.register(email: email, password: password);

        return (true, null);
      } catch (e) {
        isLoading$.value = false;

        return (false, e.toString());
      }
    } else if (password != passwordConfirmation) {
      isLoading$.value = false;

      return (false, 'As senhas não são iguais!');
    } else {
      isLoading$.value = false;

      return (false, 'Verifique as informações!');
    }
  }
}
