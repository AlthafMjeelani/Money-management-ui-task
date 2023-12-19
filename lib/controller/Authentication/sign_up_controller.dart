// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demotask/view/dashboard/screen_dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:demotask/helper/core/color_constant.dart';
import 'package:demotask/helper/core/message.dart';
import 'package:demotask/helper/core/routes.dart';
import 'package:demotask/helper/storage/local_storage.dart';
import 'package:demotask/model/user_model.dart';
import 'package:demotask/utility/enum_address.dart';
import 'package:demotask/view/Authentication/screen_otp.dart';

class SignUpController with ChangeNotifier {
  TextEditingController mobileController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  bool passwordShow = false;
  bool isLoadRegister = false;

  void changepasswodVisibility() {
    passwordShow = !passwordShow;
    notifyListeners();
  }

  String? verificationResponseId;

  Future<void> sendOTP(String phoneNumber, context, String type) async {
    try {
      isLoadRegister = true;
      notifyListeners();
      verificationCompleted(PhoneAuthCredential credential) async {}

      verificationFailed(FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          log('The provided phone number is not valid.');
        }
        isLoadRegister = false;
        notifyListeners();
      }

      codeSent(String verificationId, [int? forceResendingToken]) {
        verificationResponseId = verificationId;
        notifyListeners();
        isLoadRegister = false;
        notifyListeners();
        if (type == 'register') {
          RouteConstat.nextNamed(context,
              ScreenOtp(mobile: phoneNumber, type: ActionTypeOTP.loginOTP));
        }
      }

      codeAutoRetrievalTimeout(String verificationId) {
        // Auto-retrieval of OTP timed out
      }

      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
      );
    } on FirebaseAuthException catch (e) {
      isLoadRegister = false;
      notifyListeners();
      showToast(msg: e.message.toString(), clr: AppColoring.errorPopUp);
      log(e.toString());
    } catch (e) {
      isLoadRegister = false;
      showToast(msg: e.toString(), clr: AppColoring.errorPopUp);
      notifyListeners();
      log(e.toString());
    }
  }

  bool verfiOtpRegister = false;

  Future<void> verifyOTP(String smsCode, BuildContext context) async {
    verfiOtpRegister = true;
    notifyListeners();
    try {
      PhoneAuthProvider.credential(
          verificationId: verificationResponseId ?? '123456', smsCode: smsCode);

      await auth
          .createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text)
          .then((value) async {
        UserModel userModel = UserModel(
          email: auth.currentUser!.email,
          name: nameController.text,
          mob: mobileController.text,
        dob: '',
        pp: ''
        );

        await firebaseFirestore
            .collection(emailController.text.toString())
            .doc(auth.currentUser!.uid)
            .set(userModel.toMap())
            .then((value)async {
          verfiOtpRegister = false;
          notifyListeners();
          await LocalStorage.saveUserLoggedInStatus('true');
          RouteConstat.nextRemoveUntileNamed(context, const DashboardScreen());
        });
      });
      verfiOtpRegister = false;
      notifyListeners();
      showToast(clr: Colors.green, msg: 'New user Creted Successfully');
      //navigation(context);
    } on FirebaseAuthException catch (e) {
      verfiOtpRegister = false;
      notifyListeners();
      switch (e.code) {
        case 'invalid-email':
          return showToast(
              clr: Colors.red, msg: 'The email address is Not correct format');
        case 'weak-password':
          return showToast(
              clr: Colors.red,
              msg: 'Password should be at least 6 characterst');
        case 'email-already-in-use':
          return showToast(
              clr: Colors.red,
              msg: 'The email address is already in use by another account');
        default:
          return showToast(
              clr: Colors.red,
              msg: 'The email Or Password is Not correct format');
      }
    } catch (e) {
      verfiOtpRegister = false;
      notifyListeners();
      log(e.toString());
    }
  }
}
