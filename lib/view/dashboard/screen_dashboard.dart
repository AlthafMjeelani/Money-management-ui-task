
import 'package:demotask/controller/dashboard/dashboard_controller.dart';
import 'package:demotask/helper/core/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
 


  late DashboardController dashboardController;
  @override
  void initState() {
    dashboardController =
        Provider.of<DashboardController>(context, listen: false);
    dashboardController.currentPageIndex = 0;

    super.initState();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardController>(
      builder:
          (BuildContext context, DashboardController value, Widget? child) {
        return WillPopScope(
          onWillPop: () async {
            value.bottomNavbar();
            return false;
          },
          child: Scaffold(
           

            
            
            bottomNavigationBar:

             BottomNavigationBar(
              elevation: 0,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              selectedItemColor: AppColoring.kAppColor,
              unselectedItemColor: const Color.fromARGB(255, 70, 69, 69),
              selectedLabelStyle: TextStyle(color: AppColoring.kAppColor),
              currentIndex: value.currentPageIndex,
              onTap: (newIndex) {
                value.bottomShift(newIndex);
              },
              type: BottomNavigationBarType.fixed,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    size: 30,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.equalizer,
                    size: 30,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.grid_view,
                    size: 30,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person,
                    size: 32,
                  ),
                  label: '',
                ),
              ],
            ),
            body: value.pages[value.currentPageIndex],
          ),
        );
      },
    );
  }
}
