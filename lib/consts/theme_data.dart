import 'package:flutter/material.dart';
import 'package:movegui/consts/app_colors.dart';

class Styles {
  Color? appBackgroundColor;
  static ThemeData themeData({
    required bool isDarkTheme,
    required BuildContext context,
  }) {
    return ThemeData(
      primaryColor: Color(0xFF871A1C),
      secondaryHeaderColor: Colors.white ,
      scaffoldBackgroundColor:
          isDarkTheme
              ? AppColors.darkScaffoldColor
              : AppColors.lightScaffoldColor,
      cardColor:
          isDarkTheme
              ? const Color.fromARGB(255, 13, 6, 37)
              : AppColors.lightCardColor,
      brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      bottomAppBarTheme: BottomAppBarTheme(
        color: AppColors.error 
      ),
      
    );
  }
}
