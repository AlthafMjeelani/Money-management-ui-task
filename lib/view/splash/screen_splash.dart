//
// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:developer';
import 'package:demotask/view/dashboard/screen_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:demotask/helper/core/routes.dart';
import 'package:demotask/helper/storage/local_storage.dart';
import 'package:demotask/view/Authentication/screen_signin.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<ScreenSplash>
    with SingleTickerProviderStateMixin {
  var _visible = true;
  void checkLogin() async {
    final user = await LocalStorage.getUserLoggedInStatus();
    log(user.toString());
    if (user == 'true') {
      
      RouteConstat.nextRemoveUntileNamed(context,  const DashboardScreen());
    } else {
    
      RouteConstat.nextRemoveUntileNamed(context, const ScreenSignIn());
    }
  }

  AnimationController? animationController;
  Animation<double>? animation;
  startTime() async {
    //await Geolocator.requestPermission();
    var duration = const Duration(seconds: 2);
    return Timer(duration, navigationPage);
  }

  void navigationPage() {
    checkLogin();
  }

  @override
  dispose() {
    animationController!.dispose(); // you need this
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
    animation =
        CurvedAnimation(parent: animationController!, curve: Curves.easeOut);

    animation!.addListener(() => setState(() {}));
    animationController!.forward();

    setState(() {
      _visible = !_visible;
    });
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Image.asset(
              //   Utils.setPngPath("logo"),
              //   width: animation!.value * 250,
              //   height: animation!.value * 250,
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
