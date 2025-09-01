import 'package:flutter/material.dart';
import 'package:hello_world/root/screens/countries_explorer_screen.dart';
import 'package:hello_world/root/screens/profile_page.dart';
import 'package:sizer/sizer.dart';
import 'package:responsive_framework/responsive_framework.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        'Hello World',
        style: TextStyle(
          fontSize: 20.sp,
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
        if (ResponsiveBreakpoints.of(context).isMobile)
          IconButton(
            icon: const Icon(Icons.public),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CountriesExplorerScreen(),
                ),
              );
            },
          ),
        if (ResponsiveBreakpoints.of(context).isTablet ||
            ResponsiveBreakpoints.of(context).isDesktop)
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CountriesExplorerScreen(),
                ),
              );
            },
            icon: const Icon(Icons.public),
            label: const Text('Explore World'),
          ),
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
