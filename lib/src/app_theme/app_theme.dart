import 'package:flutter/material.dart';

class AppTheme {
  static Color backgroundColor = const Color.fromARGB(255, 61, 61, 61);
  static Color contanierColor = const Color.fromARGB(255, 87, 87, 87);
  static Color shadowColor = const Color.fromARGB(255, 32, 32, 32);
  static Color fontColor = const Color.fromARGB(255, 190, 190, 190);
  static Color borderColor = const Color.fromARGB(255, 136, 136, 136);
  static List<BoxShadow> containerShadows = [
    BoxShadow(
      color: AppTheme.shadowColor,
      blurRadius: 4.0,
      spreadRadius: 1.0,
      offset: const Offset(3, 5),
    ),
    BoxShadow(
      color: AppTheme.shadowColor,
      blurRadius: 4.0,
      spreadRadius: 1.0,
      offset: const Offset(-3, 5),
    ),
  ];
  static List<BoxShadow> buttonShadows = [
    BoxShadow(
      color: AppTheme.shadowColor,
      blurRadius: 4.0,
      spreadRadius: -3.0,
      offset: const Offset(6, 3),
    ),
    BoxShadow(
      color: AppTheme.shadowColor,
      blurRadius: 4.0,
      spreadRadius: -3.0,
      offset: const Offset(-6, 3),
    ),
  ];
}
