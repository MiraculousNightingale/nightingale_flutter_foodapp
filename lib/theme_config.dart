import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeConfig {
  static final defaultTheme = ThemeData();
  static final theme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: const Color.fromRGBO(29, 21, 19, 1),
    ),
    textTheme: GoogleFonts.latoTextTheme(),
  );
}
