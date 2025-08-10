import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.grey,
      elevation: 8.0,
      centerTitle: true,
      title: RichText(
        text: TextSpan(
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontSize: 28),
          children: const <TextSpan>[
            TextSpan(
              text: 'Hello',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
              ),
            ),
            TextSpan(
              text: ' World',
              style: TextStyle(color: Colors.green),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}