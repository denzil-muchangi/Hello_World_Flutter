import 'package:flutter/material.dart';
import 'package:hello_world/root/theme.dart';
import 'package:hello_world/root/theme_notifier.dart';
import 'package:provider/provider.dart';

class ThemeSelection extends StatelessWidget {
  const ThemeSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    
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