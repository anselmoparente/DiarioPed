import 'package:flutter/material.dart';
import 'package:diarioped/app/data/services/auth_service.dart';

class RegisterController {
  var isLoading$ = ValueNotifier(false);
  bool get isLoading => isLoading$.value;

  final AuthService _auth = AuthService();

  Future<(bool, String?)> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    isLoading$.value = true;

    if (email.isNotEmpty &&
        (password.isNotEmpty && passwordConfirmation.isNotEmpty) &&
        password == passwordConfirmation &&
        name.length > 6) {
      try {
        await _auth.register(name: name, email: email, password: password);

        isLoading$.value = false;

        return (true, null);
      } on AuthException catch (e) {
        isLoading$.value = false;

        return (false, e.message);
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
