import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:diarioped/app/data/models/patient_model.dart';
import 'package:diarioped/app/data/services/auth_service.dart';

class DashboardController {
  List<PatientModel> patients = [];

  String getLink({required AuthService auth}) {
    return auth.user!.uid;
  }

  Future<void> getPatients({required AuthService auth}) async {
    DatabaseReference reference = FirebaseDatabase.instance.ref().child(
          'users/${auth.user!.uid}',
        );

    final snapshot = await reference.get();
    var data = jsonEncode(snapshot.value);
    Map<String, dynamic> map = jsonDecode(data);
    List<String> ids = map['ids'].cast<String>().toList();

    for (String id in ids) {
      DatabaseReference referencePatient =
          FirebaseDatabase.instance.ref().child(
                'patients/$id',
              );
      final snapshot = await referencePatient.get();
      var data = jsonEncode(snapshot.value);
      Map<String, dynamic> mapPatient = jsonDecode(data);

      final map = {'id': id};
      mapPatient.addEntries(map.entries);

      PatientModel patient = PatientModel.fromMap(mapPatient);

      if (!patients.contains(patient)) {
        patients.add(patient);
      }
    }
  }
}
