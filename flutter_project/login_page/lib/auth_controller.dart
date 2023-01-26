

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:login_page/login_screen.dart';
import 'package:login_page/welcome_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthController extends GetxController {
  //AuthController.instance.....
  static AuthController instance = Get.find(); // for globally accesesable in app.
  // email, password, name, ...
  late Rx<User?> _user;
  FirebaseAuth auth = FirebaseAuth.instance; // using ---> auth , we access many firebase property

  @override
  void onReady(){
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
    // our user would be notified
    _user.bindStream(auth.userChanges()); // _user is notify when, things changes like: log-in, log-out
    ever(_user,_initialScreen); // _user ---> lisitner, _initialScreen ---> call back function
  }

  _initialScreen(User? user) {
    // no body loged in yet or no body trying to login
    if(user == null) {
      print("login page");
      Get.offAll(()=>LoginPage()); // user login nai hoy to ene login page per mokli dese.
    } else {
      Get.offAll(()=>WelcomePage(email:user.email.toString())); // user login hoy to ene Welcom page per mokli dese.
    }
  }

  void register(String email, password)async {
    try {
      await auth.createUserWithEmailAndPassword(email: email, password: password);
    } catch(e) {
      Get.snackbar("About User", "User message",
        backgroundColor: Colors.redAccent,
        snackPosition: SnackPosition.BOTTOM,
        titleText: Text(
          "Account creation failed",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        messageText: Text(
          e.toString(),
            style: TextStyle(
              color: Colors.white,
            ),
        ),
      );
    }
  }

  void login(String email, password)async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } catch(e) {
      Get.snackbar("About Login", "Login message",
        backgroundColor: Colors.redAccent,
        snackPosition: SnackPosition.BOTTOM,
        titleText: Text(
          "Login failed",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        messageText: Text(
          e.toString(),
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      );
    }
  }

  void logOut()async {
    await auth.signOut();
  }
}