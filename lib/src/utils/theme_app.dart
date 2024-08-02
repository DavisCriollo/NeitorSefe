import 'package:flutter/material.dart';

class ColorManager {
  static final ColorManager _instance = ColorManager._internal();

  factory ColorManager() {
    return _instance;
  }

  ColorManager._internal();

  List<Color?> savedColors = List.filled(3, null);

  void setLoggedInColorHex(List<String> colorHexList) {
    if (colorHexList.length == 3) {
      savedColors = colorHexList.map((hex) => _hexToColor(hex)).toList();
    }
  }

  Color _hexToColor(String hexColor) {
    hexColor = hexColor.replaceAll("#", "");
    return Color(int.parse(hexColor, radix: 16) + 0xFF000000);
  }
}