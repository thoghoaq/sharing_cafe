import 'package:flutter/material.dart';
import 'package:sharing_cafe/util/app_constants.dart';

ThemeData dark({Color color = const Color(0xffA4634D)}) => ThemeData(
  useMaterial3: false,
  fontFamily: AppConstants.fontFamily,
  primaryColor: color,
  secondaryHeaderColor: const Color.fromARGB(255, 204, 125, 99),
  disabledColor: const Color(0xffa2a7ad),
  brightness: Brightness.dark,
  hintColor: const Color(0xFFbebebe),
  cardColor: const Color(0xFF30313C),
  textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(foregroundColor: color)), colorScheme: ColorScheme.dark(primary: color, secondary: color).copyWith(background: const Color(0xFF191A26)).copyWith(error: const Color(0xFFdd3135)),
);
