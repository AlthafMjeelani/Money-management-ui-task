import 'package:flutter/material.dart';

ThemeData dark({Color color = const Color(0xff283470)}) => ThemeData(
      // useMaterial3: true,
      fontFamily: 'Roboto',
      primaryColor: color,
      secondaryHeaderColor: const Color(0xFF009f67),
      disabledColor: const Color(0xffa2a7ad),
      brightness: Brightness.dark,
      hintColor: const Color(0xFFbebebe),
      cardColor: Colors.black,
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: color)),
      colorScheme: ColorScheme.dark(primary: color, secondary: color)
          .copyWith(background: const Color(0xFF343636))
          .copyWith(
            error: const Color(0xFFdd3135),
          ),

    primaryColorDark: color,
    iconTheme: const IconThemeData(color: Colors.white),
    bannerTheme: MaterialBannerThemeData(
      backgroundColor: Colors.amber.shade900.withAlpha(200),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: Colors.grey[900],
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey[800],
    ),
    floatingActionButtonTheme:  FloatingActionButtonThemeData(
      backgroundColor: color
    ),
    scaffoldBackgroundColor: Colors.grey[800],
    splashColor: Colors.grey[900],
    );
