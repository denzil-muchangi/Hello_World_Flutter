import 'package:flutter/material.dart';
import 'package:hello_world/root/theme.dart';
import 'package:hello_world/root/theme_notifier.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                themeNotifier.changeTheme(lightTheme);
              },
              child: const Text('Light Theme'),
            ),
            ElevatedButton(
              onPressed: () {
                themeNotifier.changeTheme(darkTheme);
              },
              child: const Text('Dark Theme'),
            ),
            ElevatedButton(
              onPressed: () {
                themeNotifier.changeTheme(coloredTheme);
              },
              child: const Text('Colored Theme'),
            ),
          ],
        ),
      ),
    );
  }
}