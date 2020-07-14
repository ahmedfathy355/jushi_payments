import 'package:flutter/material.dart';

class COLOR_CONST {
  //https://gist.github.com/lopspower/03fb1cc0ac9f32ef38f4

  static const Color c1 = const Color(0xffF2F4F7);
  static const Color c2 = const Color(0xffA254F2);
  static const Color c3 = const Color(0xffA6B1C0);
  static const Color c4 = const Color(0xff51EFDE);
  static const Color c5 = const Color(0xffFF958F);
  static const Color c6 = const Color(0xff8851F1);
  static const Color c7 = const Color(0xff3A4759);
  static const Color c8 = const Color(0xffF2F4F7);


}


class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}