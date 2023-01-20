import "dart:math";

import 'package:flutter/material.dart';

class Responsive {
  static double? _width;
  static double? _height;
  static double? _diagonal;

  Responsive._();

  static Responsive of(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    _width = size.width;
    _height = size.height;

    _diagonal = sqrt((pow(_width!, 2) + pow(_height!, 2)));
    return Responsive._();
  }

  double wp(double percent) {
    double value = 0;
    value = (_width! * percent) / 100;
    return value;
  }

  double hp(double percent) {
    double value = 0;
    value = (_height! * percent) / 100;
    return value;
  }

  double dp(double percent) {
    double value = 0;
    value = (_diagonal! * percent) / 100;
    return value;
  }
}
