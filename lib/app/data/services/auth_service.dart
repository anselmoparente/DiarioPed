import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthException {
  String message;
  AuthException(this.message);
}

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // FirebaseFirestore db = FirebaseFirestore.instance;
  User? user;
  bool isLoading = true;

  AuthService() {
    _authCheck();
  }

  _authCheck() {
    _auth.authStateChanges().listen((User? userListener) {
      user = (userListener == null) ? userListener : null;
      isLoading = false;
      notifyListeners();
    });
  }

  _getUser() {
    user = _auth.currentUser;
    notifyListeners();
  }

  Future<void> register({
    required String email,
    required String password,
    // required AdvocateModel advocate,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      _getUser();

      // db.collection('lawyers').doc(user!.uid).set(
      //   {
      //     'id': user!.uid,
      //     'name': advocate.name,
      //     'phone': advocate.phone,
      //     'cpf': advocate.cpf,
      //     'oab': advocate.oab,
      //     'officeAddress': advocate.officeAddress,
      //     'officeWebsite': advocate.officeWebsite,
      //     'image': advocate.image,
      //   },
      // );
    } on FirebaseAuthException catch (e) {
      log('error: ${e.code}');
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
      _getUser();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
        throw AuthException('Verifique suas credenciais!');
      }
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    _getUser();
  }
}
