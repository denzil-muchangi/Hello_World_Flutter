import 'package:flutter/material.dart';
import 'package:hello_world/root/screens/profile_page.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        'Hello World',
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
          color: Theme.of(context).brightness == Brightness.dark 
              ? Colors.white 
              : Theme.of(context).primaryColor,
          shadows: [
            Shadow(
              blurRadius: 3.0,
              color: Theme.of(context).brightness == Brightness.dark 
                  ? Colors.black.withValues(alpha: 0.5)
                  : Colors.grey.withValues(alpha: 0.5),
              offset: const Offset(1.0, 1.0),
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.person),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfilePage()),
            );
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}