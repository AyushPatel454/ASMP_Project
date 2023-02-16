import 'package:flutter/material.dart';

import '../models/user.dart';
import '../resources/auth_methods.dart';

class UserProvider with ChangeNotifier {
  User? _user; // making private field. // nullabel.
  final AuthMethods _authMethods = AuthMethods();

  User get getUser =>  _user!;

  Future<void> refreshUser() async { // refresh user every time.
    User user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners(); // it notify all the listener provider k _user (gobal) data is changed so you need to update your value.
  }
}