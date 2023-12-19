import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demotask/view/dashboard/screen_dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:demotask/helper/core/message.dart';
import 'package:demotask/helper/core/routes.dart';
import 'package:demotask/helper/storage/local_storage.dart';

class LoginController with ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isLoadLogin = false;
  bool passwordShow = false;

  void changepasswodVisibility() {
    passwordShow = !passwordShow;
    notifyListeners();
  }

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  dynamic signInUserAccount(
    context,
  ) async {
    try {
      isLoadLogin = true;
      notifyListeners();
      await auth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      isLoadLogin = false;
      notifyListeners();
      await LocalStorage.saveUserLoggedInStatus('true');
      RouteConstat.nextRemoveUntileNamed(context, const DashboardScreen());
      return Future.value('');
    } on FirebaseAuthException catch (e) {
      isLoadLogin = false;
      notifyListeners();
      switch (e.code) {
        case 'invalid-email':
          return showToast(clr: Colors.red, msg: 'Inavlid Email Id');
        case 'wrong-password':
          return showToast(clr: Colors.red, msg: 'Inavlid Password');
        case 'user-not-found':
          return showToast(clr: Colors.red, msg: 'Invalid Email Or Password');
        default:
          log(e.toString());
      }
    }
  }
}
