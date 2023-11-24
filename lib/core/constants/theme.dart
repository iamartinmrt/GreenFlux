import 'package:flutter/material.dart';
import 'package:green_flux/core/color/color_palette.dart';

class CustomTheme{
  static ThemeData themeData = ThemeData(
    scaffoldBackgroundColor: ColorPalette.white,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0)
        ),
        elevation: 0,
        backgroundColor: ColorPalette.primary,
        disabledBackgroundColor: ColorPalette.primary,
      )
    )
  );
}