import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/style.dart';
import 'package:provider/provider.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:demotask/controller/Authentication/login_controller.dart';
import 'package:demotask/controller/Authentication/sign_up_controller.dart';
import 'package:demotask/controller/Authentication/snd_otp_controller.dart';
import 'package:demotask/helper/core/app_spacing.dart';
import 'package:demotask/helper/core/color_constant.dart';
import 'package:demotask/helper/core/message.dart';
import 'package:demotask/utility/enum_address.dart';

class ScreenOtp extends StatefulWidget {
  const ScreenOtp({
    super.key,
    required this.mobile,
    required this.type,
  });
  final String mobile;
  final ActionTypeOTP type;

  @override
  State<ScreenOtp> createState() => _ScreenOtpState();
}

class _ScreenOtpState extends State<ScreenOtp> {
  late SendOTPController sendOTPController;

  @override
  void initState() {
    sendOTPController = Provider.of<SendOTPController>(context, listen: false);
    sendOTPController.changeTimer();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      sendOTPController.setTimer();
    });
      context.read<SignUpController>().verfiOtpRegister=false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: AppColoring.kAppBlueColor,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 60,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 60.0),
              child: SizedBox(
                height: 160,
                //child: Image.asset(Utils.setPngPath("logo")),
              ),
            ),
            AppSpacing.ksizedBox50,
            welcomeTextRow(),
            otpText(),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: form(),
            ),
            const SizedBox(height: 40),
            const SizedBox(height: 30),
            button(),
          ],
        ),
      ),
    );
  }

  Widget welcomeTextRow() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        AppSpacing.ksizedBoxW30,
        Text(
          "Verification",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: AppColoring.textDark),
        ),
      ],
    );
  }

  otpText() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Add verification code sent on your number',
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: AppColoring.textDark.withOpacity(0.5),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
          ),
        ],
      ),
    );
  }

  Widget form() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        children: <Widget>[
          otpTextFormField(),
        ],
      ),
    );
  }

  Widget otpTextFormField() {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10, bottom: 5, top: 20),
      child: Consumer(
        builder: (context, SendOTPController otpContr, child) {
          return Column(
            children: [
              OTPTextField(
                  controller: otpContr.otpController,
                  length: 6,
                  width: MediaQuery.of(context).size.width,
                  textFieldAlignment: MainAxisAlignment.spaceAround,
                  fieldWidth: 50,
                  keyboardType: TextInputType.number,
                  // obscureText: otpContr.isShowPIN,
                  fieldStyle: FieldStyle.box,
                  outlineBorderRadius: 8,
                  style: const TextStyle(fontSize: 17),
                  onChanged: (pin) {
                    log('PIN Changed: $pin');
                    otpContr.setPinFromPayment(pin);
                  },
                  onCompleted: (pin) {
                    if (kDebugMode) {
                      print('Completed: $pin');
                    }
                  }),
              AppSpacing.ksizedBox10,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  timeCountWidget(),
                  // otpContr.isShowPIN
                  //     ? TextButton.icon(
                  //         onPressed: () {
                  //           otpContr.showPin();
                  //         },
                  //         icon: Icon(
                  //           Icons.remove_red_eye,
                  //           color: AppColoring.kAppColor.withOpacity(.8),
                  //         ),
                  //         label: Text(
                  //           'Show',
                  //           style: TextStyle(
                  //             color: AppColoring.kAppColor.withOpacity(.8),
                  //           ),
                  //         ),
                  //       )
                  //     : TextButton.icon(
                  //         onPressed: () {
                  //           otpContr.showPin();
                  //         },
                  //         icon: Icon(
                  //           Icons.remove_red_eye,
                  //           color: AppColoring.kAppColor.withOpacity(.8),
                  //         ),
                  //         label: Text(
                  //           'Less',
                  //           style: TextStyle(
                  //             color: AppColoring.kAppColor.withOpacity(.8),
                  //           ),
                  //         ),
                  //       ),
                ],
              )
            ],
          );
        },
      ),
    );
  }

  Widget timeCountWidget() {
    return Consumer2(
      builder:
          (context, SendOTPController otpContr, SignUpController value, child) {
        return Row(
          children: [
            AppSpacing.ksizedBoxW15,
            otpContr.timeRemaining != 0
                ? Text(
                    '00:${otpContr.timeRemaining}',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w500),
                  )
                : InkWell(
                    onTap: () async {
                      otpContr.setTimer();
                      if (widget.type == ActionTypeOTP.loginOTP) {
                        value.sendOTP('+91${value.mobileController.text}',
                            context, 'resend');
                      }
                    },
                    child: Text(
                      'RESEND',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  )
          ],
        );
      },
    );
  }

  Widget button() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Consumer2(
        builder: (context, SignUpController value, SendOTPController otpContr,
            child) {
          return value.verfiOtpRegister
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    padding: const EdgeInsets.all(0.0),
                    textStyle: const TextStyle(color: AppColoring.kAppColor),
                  ),
                  onPressed: () {
                    if (otpContr.enteirdOTPController.text.length != 6) {
                      showToast(
                          msg: 'Enter valid OTP', clr: AppColoring.errorPopUp);
                    } else {
                      if (widget.type == ActionTypeOTP.loginOTP) {
                        value.verifyOTP(
                            otpContr.enteirdOTPController.text, context);
                      }
                    }
                  },
                  child: Container(
                    height: 55,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: AppColoring.kAppColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                    ),
                    padding: const EdgeInsets.all(12.0),
                    child: const Text(
                      'Submit',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColoring.kAppWhiteColor,
                      ),
                    ),
                  ),
                );
        },
      ),
    );
  }
}
