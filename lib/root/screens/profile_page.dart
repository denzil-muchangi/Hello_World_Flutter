import 'package:flutter/material.dart';
import 'package:hello_world/root/theme.dart';
import 'package:hello_world/root/theme_notifier.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final theme = Theme.of(context);

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
            children: [
              // User Profile Header
              _buildProfileHeader(theme),
              const SizedBox(height: 24),
              
              // Stats Section
              _buildStatsSection(theme),
              const SizedBox(height: 24),
              
              // Settings Section
              _buildSettingsSection(theme, themeNotifier),
              const SizedBox(height: 24),
              
              // Theme Selection
              _buildThemeSelection(theme, themeNotifier),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader(ThemeData theme) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: theme.primaryColor,
              child: const Icon(Icons.person, size: 40, color: Colors.white),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'John Doe',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'john.doe@example.com',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.textTheme.bodySmall?.color,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: theme.primaryColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Premium User',
                      style: TextStyle(
                        color: theme.primaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsSection(ThemeData theme) {
    return Row(
      children: [
        _buildStatCard(theme, '127', 'Greetings', Icons.favorite),
        const SizedBox(width: 12),
        _buildStatCard(theme, '89', 'Languages', Icons.language),
        const SizedBox(width: 12),
        _buildStatCard(theme, '5', 'Countries', Icons.flag),
      ],
    );
  }

  Widget _buildStatCard(ThemeData theme, String value, String label, IconData icon) {
    return Expanded(
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Icon(icon, color: theme.primaryColor, size: 24),
              const SizedBox(height: 8),
              Text(
                value,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.primaryColor,
                ),
              ),
              Text(
                label,
                style: theme.textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsSection(ThemeData theme, ThemeNotifier themeNotifier) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Settings',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Card(
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              _buildSettingsTile(
                theme,
                icon: Icons.notifications,
                title: 'Notifications',
                onTap: () {},
              ),
              _buildDivider(theme),
              _buildSettingsTile(
                theme,
                icon: Icons.privacy_tip,
                title: 'Privacy',
                onTap: () {},
              ),
              _buildDivider(theme),
              _buildSettingsTile(
                theme,
                icon: Icons.help,
                title: 'Help & Support',
                onTap: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsTile(ThemeData theme, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: theme.primaryColor),
      title: Text(title, style: theme.textTheme.bodyLarge),
      trailing: const Icon(Icons.chevron_right, size: 20),
      onTap: onTap,
    );
  }

  Widget _buildDivider(ThemeData theme) {
    return Divider(
      height: 1,
      indent: 16,
      endIndent: 16,
      color: theme.dividerColor.withValues(alpha: 0.3),
    );
  }

  Widget _buildThemeSelection(ThemeData theme, ThemeNotifier themeNotifier) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Appearance',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            _buildThemeOption(
              theme,
              'Light',
              Icons.light_mode,
              lightTheme,
              themeNotifier,
            ),
            const SizedBox(width: 8),
            _buildThemeOption(
              theme,
              'Dark',
              Icons.dark_mode,
              darkTheme,
              themeNotifier,
            ),
            const SizedBox(width: 8),
            _buildThemeOption(
              theme,
              'Colored',
              Icons.palette,
              coloredTheme,
              themeNotifier,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildThemeOption(
    ThemeData theme,
    String label,
    IconData icon,
    ThemeData targetTheme,
    ThemeNotifier themeNotifier,
  ) {
    final isSelected = theme.brightness == targetTheme.brightness &&
        theme.primaryColor == targetTheme.primaryColor;

    return Expanded(
      child: GestureDetector(
        onTap: () => themeNotifier.changeTheme(targetTheme),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isSelected
                ? theme.primaryColor.withValues(alpha: 0.1)
                : theme.cardColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? theme.primaryColor : theme.dividerColor,
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                color: isSelected ? theme.primaryColor : theme.iconTheme.color,
                size: 24,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: theme.textTheme.bodySmall?.copyWith(
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? theme.primaryColor : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}