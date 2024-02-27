import 'dart:developer';

import 'package:nutriped/app/data/services/auth_service.dart';

class PatientController {
  Future<bool> logout({required AuthService auth}) async {
    try {
      auth.logout();
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
