import 'package:diarioped/app/data/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InitController {
  Future<(bool, String?)> tryLogin({required AuthService auth}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final String? patientId = prefs.getString('patientId');

    if (patientId != null) {
      return (true, 'patient');
    }

    final String? email = prefs.getString('email');
    final String? pass = prefs.getString('pass');

    if (email != null && pass != null) {
      try {
        await auth.login(email, pass);

        return (true, 'doctor');
      } catch (e) {
        return (false, null);
      }
    }

    return (false, null);
  }
}
