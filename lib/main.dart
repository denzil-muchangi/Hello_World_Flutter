import 'package:flutter/material.dart';
import 'package:hello_world/root/app.dart';
import 'package:hello_world/root/theme.dart';
import 'package:hello_world/root/theme_notifier.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeNotifier(lightTheme),
      child: Sizer(
        builder: (context, orientation, deviceType) {
          return const MyApp();
        },
      ),
    ),
  );
}
