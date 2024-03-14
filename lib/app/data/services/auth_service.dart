import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthException {
  String message;
  AuthException(this.message);
}

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? user;
  bool isLoading = true;

  AuthService() {
    _authCheck();
  }

  _authCheck() {
    _auth.authStateChanges().listen((User? userListener) {
      user = (userListener != null) ? userListener : null;
      isLoading = false;
      notifyListeners();
    });
  }

  Future _getUser() async {
    user = _auth.currentUser;
    notifyListeners();
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _getUser();

      if (_auth.currentUser != null) {
        DatabaseReference reference = FirebaseDatabase.instance.ref().child(
              'users/${_auth.currentUser!.uid}',
            );

        await reference.set(
          {
            'name': name,
            'email': email,
          },
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw AuthException('A senha é muito fraca!');
      } else if (e.code == 'email-already-in-use') {
        throw AuthException('Este email já está cadastrado!');
      }
    }
  }

  Future<void> resetPassword({required String email}) async {
    await _auth.setLanguageCode('pt-br');
    await _auth.sendPasswordResetEmail(email: email);
  }

  Future<void> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      await _getUser();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        throw AuthException('Verifique suas credenciais!');
      } else if (e.code == 'too-many-requests') {
        throw AuthException(
          'Todas as solicitações deste dispositivo foram bloqueadas devido a atividades incomuns! Por favor, tente novamente mais tarde.',
        );
      } else {
        throw AuthException('Erro incomum!');
      }
    }
  }

  Future<void> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.remove('patientId');
    await prefs.remove('email');
    await prefs.remove('pass');

    await _auth.signOut();
    _getUser();
  }
}
