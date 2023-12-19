import 'package:demotask/controller/dashboard/dashboard_controller.dart';
import 'package:demotask/controller/home/home_controller.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:demotask/controller/Authentication/login_controller.dart';
import 'package:demotask/controller/Authentication/sign_up_controller.dart';
import 'package:demotask/controller/Authentication/snd_otp_controller.dart';
import 'package:demotask/controller/profile/profile_controller.dart';
import 'package:demotask/controller/theme/theme_controller.dart';

class ProviderStateController {
  static List<SingleChildWidget> providers = [
    ChangeNotifierProvider(
      create: (context) => SendOTPController(),
    ),
    ChangeNotifierProvider(
      create: (context) => LoginController(),
    ),
    ChangeNotifierProvider(
      create: (context) => SignUpController(),
    ),
    ChangeNotifierProvider(
      create: (context) => DashboardController(),
    ),

    ChangeNotifierProvider(
      create: (context) => ProfileProvider(),
    ),
      ChangeNotifierProvider(
      create: (context) => HomeController(),
    ),
  ];
}
