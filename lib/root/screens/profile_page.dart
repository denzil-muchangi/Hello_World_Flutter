import 'package:flutter/material.dart';
import 'package:hello_world/root/widgets/profile_header.dart';
import 'package:hello_world/root/widgets/stats_section.dart';
import 'package:hello_world/root/widgets/settings_section.dart';
import 'package:hello_world/root/widgets/theme_selection.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              // User Profile Header
              ProfileHeader(),
              SizedBox(height: 24),
              
              // Stats Section
              StatsSection(),
              SizedBox(height: 24),
              
              // Settings Section
              SettingsSection(),
              SizedBox(height: 24),
              
              // Theme Selection
              ThemeSelection(),
            ],
          ),
        ),
      ),
    );
  }
}