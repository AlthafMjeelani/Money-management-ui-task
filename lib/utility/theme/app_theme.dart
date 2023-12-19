// import 'package:flutter/material.dart';

//  class Styles {
   
//   static ThemeData themeData(bool isDarkTheme, BuildContext context) {
//     return ThemeData(
//       primarySwatch: Colors.red,
//       primaryColor: isDarkTheme ? Colors.black : Colors.white,

//       scaffoldBackgroundColor: isDarkTheme ? Colors.black : const Color(0xffF1F5FB),

//       indicatorColor: isDarkTheme ? const Color(0xff0E1D36) : const Color(0xffCBDCF8),
//       //buttonColor: isDarkTheme ? Color(0xff3B3B3B) : Color(0xffF1F5FB),

//       hintColor: isDarkTheme ? const Color(0xff280C0B) : const Color(0xffEECED3),

//       highlightColor: isDarkTheme ? const Color(0xff372901) : const Color(0xffFCE192),
//       hoverColor: isDarkTheme ? const Color(0xff3A3A3B) : const Color(0xff4285F4),

//       focusColor: isDarkTheme ? const Color(0xff0B2512) : const Color(0xffA8DAB5),
//       disabledColor: Colors.grey,
//       //textSelectionColor: isDarkTheme ? Colors.white : Colors.black,
//       cardColor: isDarkTheme ? const Color(0xFF151515) : Colors.white,
//       canvasColor: isDarkTheme ? Colors.black : Colors.grey[50],
//       brightness: isDarkTheme ? Brightness.dark : Brightness.light,
//       buttonTheme: Theme.of(context).buttonTheme.copyWith(
//           colorScheme: isDarkTheme ? const ColorScheme.dark() : const ColorScheme.light()),
//       appBarTheme: const AppBarTheme(
//         elevation: 0.0,
//       ),
//     );
    
//   }
// }


import 'package:flutter/material.dart';

class AppTheme{
static Color lightColor = const Color(0xff283470);
  static ThemeData lightTheme= ThemeData(
    useMaterial3: true,
  fontFamily: 'Roboto',
  primaryColor: lightColor,
  secondaryHeaderColor: const Color(0xFF1ED7AA),
  disabledColor: const Color(0xFFBABFC4),
  brightness: Brightness.light,
  hintColor: const Color(0xFF9F9F9F),
  cardColor: Colors.white,
  textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(foregroundColor: lightColor)),
  colorScheme: ColorScheme.light(primary: lightColor, secondary: lightColor).copyWith(background: const Color(0xFFF3F3F3)).copyWith(error: const Color(0xFFE84D4F)),
);

static Color darkColor = const Color(0xFF54b46b);
  static ThemeData darkTheme= ThemeData(    useMaterial3: true,

  fontFamily: 'Roboto',
  primaryColor: darkColor,
  secondaryHeaderColor: const Color(0xFF009f67),
  disabledColor: const Color(0xffa2a7ad),
  brightness: Brightness.dark,
  hintColor: const Color(0xFFbebebe),
  cardColor: Colors.black,
  textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(foregroundColor: darkColor)), colorScheme: ColorScheme.dark(primary: darkColor, secondary: darkColor).copyWith(background: const Color(0xFF343636)).copyWith(error: const Color(0xFFdd3135)),
);
}