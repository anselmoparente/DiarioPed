import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';

class LinkController {
  var isLoading$ = ValueNotifier(false);
  bool get isLoading => isLoading$.value;

  Future<(bool, String?)> linkPatient({
    required String name,
    required String link,
  }) async {
    String? deviceID;

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      var androidInfo = await deviceInfo.androidInfo;
      deviceID = androidInfo.id;
    }

    if (Platform.isIOS) {
      var iosInfo = await deviceInfo.iosInfo;
      deviceID = iosInfo.identifierForVendor!;
    }

    if (deviceID != null) {
      deviceID = deviceID.replaceAll('.', '');
    }

    final reference = FirebaseDatabase.instance.ref().child(
          'users/$link',
        );

    final snapshot = await reference.get();
    var data = jsonEncode(snapshot.value);
    Map<String, dynamic> map = jsonDecode(data);
    List<String> ids = [];

    if (map['ids'] != null) {
      ids = map['ids'].cast<String>().toList();
      if (!ids.contains(deviceID)) {
        ids.add(deviceID!);
      }
    } else {
      ids.add(deviceID!);
    }

    reference.update({'ids': ids});

    final patientReference = FirebaseDatabase.instance.ref().child(
          'patients/$deviceID',
        );

    patientReference.set({
      'name': name,
      'meals': [],
    });

    return (false, null);
  }
}
