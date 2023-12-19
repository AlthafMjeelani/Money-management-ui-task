import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';
import 'package:demotask/controller/Authentication/sign_up_controller.dart';
import 'package:demotask/helper/core/app_spacing.dart';
import 'package:demotask/helper/core/color_constant.dart';
import 'package:demotask/helper/core/message.dart';
import 'package:demotask/helper/core/routes.dart';
import 'package:demotask/view/Authentication/screen_signin.dart';
import 'package:demotask/widgets/textfeild_widget.dart';

class ScreenSignUp extends StatefulWidget {
  const ScreenSignUp({super.key});

  @override
  State<ScreenSignUp> createState() => _ScreenSignUpState();
}

class _ScreenSignUpState extends State<ScreenSignUp> {
  late SignUpController signUpController;

  @override
  void initState() {
    signUpController = Provider.of<SignUpController>(context, listen: false);
    signUpController.mobileController.clear();
    signUpController.emailController.clear();
    signUpController.mobileController.clear();

    signUpController.isLoadRegister = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    //  backgroundColor: AppColoring.kAppBlueColor,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 60,
            ),
            welcomeTextRow(),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: form(),
            ),
            const SizedBox(height: 10),
            button(),
            AppSpacing.ksizedBox40,
            signInButton(),
            AppSpacing.ksizedBox40,
          ],
        ),
      ),
    );
  }

  Widget buttonMap(String text, void Function()? onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: InkWell(
        onTap: onPressed,
        child: Column(
          children: [
            const Icon(
              Icons.location_on_outlined,
              size: 35,
              color: AppColoring.kAppColor,
            ),
            Text(text)
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
          "SIGN UP",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: AppColoring.textDark),
        ),
      ],
    );
  }

  Widget form() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        children: <Widget>[
          numberTextFormField(),
          AppSpacing.ksizedBox15,
          textFormFieldWidget(
              'Name', signUpController.nameController, TextInputType.name),
          AppSpacing.ksizedBox15,
          textFormFieldWidget('E-mail', signUpController.emailController,
              TextInputType.emailAddress),
          AppSpacing.ksizedBox15,
          textFormFieldPasswordWidget(
            'Password',
            signUpController.passwordController,
            TextInputType.name,
          ),
          AppSpacing.ksizedBox15,
        ],
      ),
    );
  }

  Widget textFormFieldPasswordWidget(String text,
      TextEditingController? controller, TextInputType? keyboardType) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: AppColoring.primeryBorder),
          borderRadius: BorderRadius.circular(10)),
      child: Consumer(
        builder: (context, SignUpController value, child) {
          return TextfeildWidget(
            obscureText: value.passwordShow,
            label: text,
            text: '',
            controller: controller,
            keyboardType: keyboardType,
            suffixIcon: InkWell(
              onTap: () {
                value.changepasswodVisibility();
              },
              child: Icon(
                value.passwordShow ? Icons.visibility_off : Icons.visibility,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget textFormFieldWidget(String text, TextEditingController? controller,
      TextInputType? keyboardType) {
    return Container(
      padding: EdgeInsets.zero,
      margin: EdgeInsets.zero,
      decoration: BoxDecoration(
          border: Border.all(color: AppColoring.primeryBorder),
          borderRadius: BorderRadius.circular(10)),
      child: TextfeildWidget(
        label: text,
        text: '',
        controller: controller,
        keyboardType: keyboardType,
      ),
    );
  }

  Widget numberTextFormField() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: AppColoring.primeryBorder),
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: InternationalPhoneNumberInput(
          onInputChanged: (PhoneNumber number) {
            debugPrint(number.phoneNumber);
          },
          onInputValidated: (bool value) {
            debugPrint(value.toString());
          },
          selectorConfig: const SelectorConfig(
            selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
          ),
          ignoreBlank: false,
          autoValidateMode: AutovalidateMode.disabled,
          selectorTextStyle: const TextStyle(color: AppColoring.textDark),
          textFieldController: signUpController.mobileController,
          formatInput: false,
          maxLength: 10,
          initialValue: PhoneNumber(isoCode: 'IN'),
          keyboardType: const TextInputType.numberWithOptions(
              signed: true, decimal: true),
          cursorColor: AppColoring.kAppColor,
          inputDecoration: InputDecoration(
            contentPadding: const EdgeInsets.only(bottom: 15, left: 0),
            border: InputBorder.none,
            hintText: 'Phone Number',
            hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 16),
          ),
          onSaved: (PhoneNumber number) {
            debugPrint('On Saved: $number');
          },
        ),
      ),
    );
  }

  Widget button() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Consumer(
        builder: (context, SignUpController value, child) {
          return value.isLoadRegister
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
                    if (value.mobileController.text.length != 10) {
                      showToast(
                          msg: 'Enter 10 digit mobile number ',
                          clr: AppColoring.errorPopUp);
                    } else if (!isValidEmail(value.emailController.text)) {
                      showToast(
                        msg: 'Enter a valid email address',
                        clr: AppColoring.errorPopUp,
                      );
                    } else if (value.emailController.text == '' ||
                        value.emailController.text.isEmpty ||
                        value.mobileController.text == '' ||
                        value.mobileController.text.isEmpty ||
                        value.nameController.text == '' ||
                        value.nameController.text.isEmpty) {
                      showToast(
                          msg: 'Enter the all fields correctly',
                          clr: AppColoring.errorPopUp);
                    } else if (value.passwordController.text.length <= 6) {
                      showToast(
                          msg: 'Password Shoud be more than 6 letter',
                          clr: AppColoring.errorPopUp);
                    } else {
                      value.sendOTP('+91${value.mobileController.text}',
                          context, 'register');
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
                      'Continue',
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

  bool isValidEmail(String email) {
    // Regular expression for basic email validation
    String emailRegex = r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$';
    RegExp regex = RegExp(emailRegex);
    return regex.hasMatch(email);
  }

  Widget signInButton() {
    return RichText(
      text: TextSpan(
        text: "Already have an account?  ",
        children: [
          TextSpan(
            text: "Sign In",
            style: const TextStyle(
                color: AppColoring.kAppColor,
                fontSize: 18,
                fontWeight: FontWeight.w500),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                RouteConstat.nextRemoveUntileNamed(
                    context, const ScreenSignIn());
              },
          ),
        ],
        style: const TextStyle(color: AppColoring.textDim, fontSize: 18),
      ),
    );
  }
}
