import 'package:flutter/material.dart';
import 'package:hello_world/root/screens/home_page.dart';
import 'package:hello_world/root/theme_notifier.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return MaterialApp(
      title: 'Flutter Hello World',
      theme: themeNotifier.currentTheme,
      home: const MyHomePage(title: 'Hello World'),
    );
  }
}