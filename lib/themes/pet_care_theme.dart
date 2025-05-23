import 'package:flutter/material.dart';

class PetCareTheme {
  static Color orange_50 = Color.fromRGBO(255, 230, 185, 1);
  static Color orange_100 = Color.fromRGBO(239, 187, 76, 1);
  static Color orange_300 = Color.fromRGBO(239, 115, 65, 1);
  static Color orange_500 = Color.fromRGBO(215, 131, 63, 1);

  static Color blue_250 = Color.fromRGBO(185, 213, 217, 1);
  static Color blue_300 = Color.fromRGBO(22, 148, 165, 1);

  static Color pink_100 = Color.fromRGBO(254, 144, 133, 1);
  static Color pink_300 = Color.fromRGBO(254, 92, 91, 1);
  static Color pink_900 = Color.fromRGBO(215, 44, 141, 1);

  static Color white = Color.fromRGBO(255, 255, 255, 1);
  static Color white_50 = Color.fromRGBO(247, 240, 232, 1);

  static ThemeData theme = ThemeData(
    useMaterial3: false,
    fontFamily: 'SanFrancisco',
    scaffoldBackgroundColor: white_50,
    colorScheme: ColorScheme(
      surface: white_50,
      brightness: Brightness.light,
      primary: Color.fromRGBO(0, 0, 0, 1),
      onPrimary: Color.fromRGBO(0, 0, 0, 1),
      secondary: Color.fromRGBO(0, 0, 0, 1),
      onSecondary: Color.fromRGBO(0, 0, 0, 1),
      error: Color.fromRGBO(0, 0, 0, 1),
      onError: Color.fromRGBO(0, 0, 0, 1),
      onSurface: Color.fromRGBO(0, 0, 0, 1),
      tertiary: Color.fromRGBO(0, 0, 0, 1),
    ),
    canvasColor: Color.fromRGBO(0, 0, 0, 1),
    appBarTheme: AppBarTheme(
      backgroundColor: white_50,
      shadowColor: null,
    ),
  );
}
