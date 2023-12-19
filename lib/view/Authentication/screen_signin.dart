import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:demotask/controller/Authentication/login_controller.dart';
import 'package:demotask/controller/Authentication/snd_otp_controller.dart';
import 'package:demotask/helper/core/app_spacing.dart';
import 'package:demotask/helper/core/color_constant.dart';
import 'package:demotask/helper/core/message.dart';
import 'package:demotask/helper/core/routes.dart';
import 'package:demotask/view/Authentication/screen_signup.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:demotask/widgets/textfeild_widget.dart';

class ScreenSignIn extends StatefulWidget {
  const ScreenSignIn({super.key});

  @override
  State<ScreenSignIn> createState() => _ScreenSignInState();
}

class _ScreenSignInState extends State<ScreenSignIn> {
  late LoginController loginController;

  @override
  void initState() {
    loginController = Provider.of<LoginController>(context, listen: false);
    loginController.isLoadLogin = false;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      loginController.emailController.clear();

      loginController.passwordController.clear();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // backgroundColor: AppColoring.kAppBlueColor,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            AppSpacing.ksizedBox40,
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 60.0),
              child: SizedBox(
                height: 160,
                // child: Image.asset(
                //   Utils.setPngPath("logo"),
                //   fit: BoxFit.fill,
                // ),
              ),
            ),
            AppSpacing.ksizedBox10,
            welcomeTextRow(),
            AppSpacing.ksizedBox10,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: form(),
            ),
            AppSpacing.ksizedBox50,
            button(),
            AppSpacing.ksizedBox40,
            signUpButton(),
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
          "SIGN IN",
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
          textFormFieldWidget('E-mail', loginController.emailController,
              TextInputType.emailAddress),
          AppSpacing.ksizedBox15,
          textFormFieldPasswordWidget(
            'Password',
            loginController.passwordController,
            TextInputType.name,
          ),
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
        builder: (context, LoginController value, child) {
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

  Widget button() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Consumer(
        builder: (context, LoginController value, child) {
          return value.isLoadLogin
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
                    if (!isValidEmail(value.emailController.text)) {
                      showToast(
                        msg: 'Enter a valid email address',
                        clr: AppColoring.errorPopUp,
                      );
                    } else if (value.emailController.text == '' ||
                        value.emailController.text.isEmpty ||
                        value.passwordController.text == '' ||
                        value.passwordController.text.isEmpty) {
                      showToast(
                          msg: 'Enter the all fields correctly',
                          clr: AppColoring.errorPopUp);
                    } else if (value.passwordController.text.length <= 6) {
                      showToast(
                          msg: 'Password Shoud be more than 6 letter',
                          clr: AppColoring.errorPopUp);
                    } else {
                      value.signInUserAccount(context);
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
                      'LOGIN',
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

  Widget signUpButton() {
    return RichText(
      text: TextSpan(
        text: "Don't have an account?  ",
        children: [
          TextSpan(
            text: "Sign Up",
            style: const TextStyle(
                color: AppColoring.kAppColor,
                fontSize: 18,
                fontWeight: FontWeight.w500),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                RouteConstat.nextNamed(context, const ScreenSignUp());
              },
          ),
        ],
        style: const TextStyle(color: AppColoring.textDim, fontSize: 18),
      ),
    );
  }
}
