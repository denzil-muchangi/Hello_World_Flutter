import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.blue,
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.indigo,
);

final ThemeData coloredTheme = ThemeData(
  primarySwatch: Colors.pink,
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: Colors.pink,
    accentColor: Colors.amber,
    cardColor: Colors.greenAccent,
    backgroundColor: Colors.lightBlueAccent,
    errorColor: Colors.red,
    brightness: Brightness.light,
  ),
);