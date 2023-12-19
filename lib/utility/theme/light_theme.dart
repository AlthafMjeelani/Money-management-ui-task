import 'package:flutter/material.dart';

ThemeData light({Color color = const Color(0xff283470)}) => ThemeData(
      // useMaterial3: true,
      fontFamily: 'Roboto',
      primaryColor: color,
      secondaryHeaderColor: const Color(0xFF1ED7AA),
      disabledColor: const Color(0xFFBABFC4),
      brightness: Brightness.light,
      hintColor: const Color(0xFF9F9F9F),
      cardColor: Colors.white,
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: color)),
      colorScheme: ColorScheme.light(primary: color, secondary: color)
          .copyWith(background: const Color(0xFFF3F3F3))
          .copyWith(
            error: const Color(0xFFE84D4F),
          ),

          primaryColorLight:color,
    primaryColorDark: Colors.yellow[700],
    iconTheme: const IconThemeData(color: Colors.black54),
    bannerTheme: MaterialBannerThemeData(
      backgroundColor: Colors.amber.shade500,
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.white,
    ),
    floatingActionButtonTheme:  FloatingActionButtonThemeData(
        backgroundColor:  color
    ),
    splashColor: Colors.white,
    appBarTheme: AppBarTheme()
    );