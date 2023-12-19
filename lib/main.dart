import 'package:demotask/helper/core/color_constant.dart';
import 'package:demotask/view/dashboard/screen_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:demotask/controller/theme/theme_controller.dart';
import 'package:demotask/helper/core/app_constant.dart';
import 'package:demotask/helper/core/state_controller.dart';
import 'package:demotask/utility/theme/dark_theme.dart';
import 'package:demotask/utility/theme/light_theme.dart';
import 'package:demotask/view/splash/screen_splash.dart';
import 'package:firebase_core/firebase_core.dart';

void main()async {
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: ProviderStateController.providers,
      child:
          MaterialApp(
            builder: (context, child) {
              final MediaQueryData data = MediaQuery.of(context);
              return MediaQuery(
                data: data.copyWith(textScaler: const TextScaler.linear(1.0)),
                child: child!,
              );
            },
            debugShowCheckedModeBanner: false,
            title: AppConstant.appName,
               theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
                seedColor: const Color.fromARGB(255, 255, 255, 255)),
            primarySwatch: AppColoring.primaryApp,
            useMaterial3: true,
          ),
            home: const ScreenSplash(),
          ),
    );
  }
}
