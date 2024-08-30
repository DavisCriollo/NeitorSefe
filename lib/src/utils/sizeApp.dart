import 'package:flutter/material.dart';

class ScreenSize {
  final BuildContext context;

  ScreenSize(this.context);

  double get height {
    return MediaQuery.of(context).size.height;
  }

  double get width {
    return MediaQuery.of(context).size.width;
  }
}