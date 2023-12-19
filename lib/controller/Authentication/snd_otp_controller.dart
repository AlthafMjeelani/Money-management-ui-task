import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';

class SendOTPController with ChangeNotifier {
  OtpFieldController otpController = OtpFieldController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController enteirdOTPController = TextEditingController();
  int timeRemaining = 59;
  bool isShowPIN = true;
  bool enableResend = false;
  late Timer timer;
  bool checkedValue = true;
  void onRememberMeChecked(bool newValue) {
    checkedValue = newValue;
    notifyListeners();
  }

  setPinFromPayment(String pin) {
    enteirdOTPController.text = pin;
    log('PIN ---------${enteirdOTPController.text}');
    notifyListeners();
  }

  showPin() {
    isShowPIN = !isShowPIN;
    notifyListeners();
  }

  void setTimer() {
    timeRemaining = 59;
    notifyListeners();
  }

  void changeTimer() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        if (timeRemaining != 0) {
          timeRemaining--;
          notifyListeners();
        } else {
          enableResend = true;
          notifyListeners();
        }
      },
    );
  }

  void setResendVisibility(bool newValue) {
    // enableResend = newValue;
    timeRemaining = 59;
    notifyListeners();
  }

 
}
