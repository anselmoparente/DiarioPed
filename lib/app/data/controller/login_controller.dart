import 'package:flutter/material.dart';

class LoginController {
  var isLoading$ = ValueNotifier(false);
  bool get isLoading => isLoading$.value;
}
