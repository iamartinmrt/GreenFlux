import 'package:flutter/cupertino.dart';
import 'package:green_flux/core/color/color_palette.dart';

class TextStyles{
  static const title1 = TextStyle(
    color: ColorPalette.black,
    fontSize: 16,
    fontWeight: FontWeight.w700,
  );

  static const body1 = TextStyle(
    color: ColorPalette.black,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static const body2 = TextStyle(
    color: ColorPalette.description,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );
}