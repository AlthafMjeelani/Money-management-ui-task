
import 'package:demotask/view/cetegory/screen_category.dart';
import 'package:demotask/view/home/screen_home.dart';
import 'package:demotask/view/profile/profile_screen.dart';
import 'package:demotask/view/statistic/screen_statistic.dart';
import 'package:flutter/material.dart';


class DashboardController with ChangeNotifier {
  int currentPageIndex = 0;
  List pages = [
    const ScreenHome(),
    const ScreenStatistics(),
    const ScreenCategory(),
    const ScreenProfile(),
  ];

  Future<bool>? bottomNavbar() {
    if (currentPageIndex != 0) {
 
      currentPageIndex = 0;
      notifyListeners();
    } else {
      // exit(0);
    }
    return null;
  }

  void bottomShift(newIndex) {
    currentPageIndex = newIndex;

    notifyListeners();
  }


}
