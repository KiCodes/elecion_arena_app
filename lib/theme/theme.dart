import 'package:flutter/material.dart';


ThemeData darkThemeData(BuildContext context) {
  final Color primaryColor = const Color(0xFF5e27fa);  // Darker blue
  final Color secondaryColor = const Color(0xFF1aff06); // Darker orange
  final Color darkGrey = const Color(0xFF212121);

  final ColorScheme colorScheme = ColorScheme.dark(
    primary: primaryColor,
    secondary: secondaryColor,
    tertiary: Colors.black,
    background: darkGrey,
    surface: const Color(0xFF121212),
    error: Colors.red,
    onPrimary: Colors.black,
    onSecondary: Colors.black,
    onBackground: Colors.white,
    inversePrimary: primaryColor,
    inverseSurface: Colors.blueGrey,
    onSurface: Colors.white,
    onError: Colors.black,
    brightness: Brightness.dark,
  );

  return ThemeData.from(
    colorScheme: colorScheme,
    textTheme: const TextTheme(),
  ).copyWith(
    scaffoldBackgroundColor: Colors.transparent,
    iconTheme: const IconThemeData(color: Colors.white54),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
  );
}