import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color.fromARGB(255, 1, 99, 179);
  static const Color secondaryColor = Color.fromARGB(255, 7, 0, 104);
  static const Color tertiaryColor = Color.fromARGB(255, 0, 57, 155);
  static const Color backgroundColor = Color.fromARGB(255, 181, 218, 248);
  static const Color cardColor = Color.fromARGB(255, 222, 239, 253);

  static const Gradient appBarGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryColor, secondaryColor, tertiaryColor],
  );
}
