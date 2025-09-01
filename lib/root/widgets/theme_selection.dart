import 'package:flutter/material.dart';
import 'package:hello_world/root/theme.dart';
import 'package:hello_world/root/theme_notifier.dart';
import 'package:hello_world/root/widgets/theme_customization_screen.dart';
import 'package:provider/provider.dart';

class ThemeSelection extends StatefulWidget {
  const ThemeSelection({super.key});

  @override
  State<ThemeSelection> createState() => _ThemeSelectionState();
}

class _ThemeSelectionState extends State<ThemeSelection> {
  List<CustomThemeData> _customThemes = [];

  @override
  void initState() {
    super.initState();
    _loadCustomThemes();
  }

  Future<void> _loadCustomThemes() async {
    final themes = await ThemeStorage.loadCustomThemes();
    setState(() {
      _customThemes = themes;
    });
  }

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
        const SizedBox(height: 16),

        // Built-in Themes
        Text(
          'Built-in Themes',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
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
            _buildCustomThemeOption(theme, 'Create Custom', Icons.add, () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ThemeCustomizationScreen(),
                ),
              ).then((_) => _loadCustomThemes());
            }),
          ],
        ),

        // Predefined Custom Themes
        if (predefinedCustomThemes.isNotEmpty) ...[
          const SizedBox(height: 24),
          Text(
            'Predefined Themes',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: predefinedCustomThemes.map((customTheme) {
              return _buildCustomThemeCard(
                theme,
                customTheme.name,
                customTheme.toThemeData(),
                themeNotifier,
              );
            }).toList(),
          ),
        ],

        // User Custom Themes
        if (_customThemes.isNotEmpty) ...[
          const SizedBox(height: 24),
          Text(
            'Your Custom Themes',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _customThemes.map((customTheme) {
              return _buildCustomThemeCard(
                theme,
                customTheme.name,
                customTheme.toThemeData(),
                themeNotifier,
                isDeletable: true,
                onDelete: () async {
                  setState(() {
                    _customThemes.remove(customTheme);
                  });
                  await ThemeStorage.saveCustomThemes(_customThemes);
                },
              );
            }).toList(),
          ),
        ],
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
    final isSelected =
        theme.brightness == targetTheme.brightness &&
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

  Widget _buildCustomThemeOption(
    ThemeData theme,
    String label,
    IconData icon,
    VoidCallback onTap,
  ) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: theme.dividerColor, width: 1),
          ),
          child: Column(
            children: [
              Icon(icon, color: theme.iconTheme.color, size: 24),
              const SizedBox(height: 4),
              Text(
                label,
                style: theme.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.normal,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCustomThemeCard(
    ThemeData theme,
    String name,
    ThemeData targetTheme,
    ThemeNotifier themeNotifier, {
    bool isDeletable = false,
    VoidCallback? onDelete,
  }) {
    final isSelected =
        theme.brightness == targetTheme.brightness &&
        theme.primaryColor == targetTheme.primaryColor;

    return GestureDetector(
      onTap: () => themeNotifier.changeTheme(targetTheme),
      child: Container(
        width: 120,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected
              ? targetTheme.primaryColor.withValues(alpha: 0.1)
              : theme.cardColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? targetTheme.primaryColor : theme.dividerColor,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            // Color preview
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: targetTheme.primaryColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(width: 4),
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: targetTheme.colorScheme.secondary,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              name,
              style: theme.textTheme.bodySmall?.copyWith(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? targetTheme.primaryColor : null,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            if (isDeletable && onDelete != null) ...[
              const SizedBox(height: 4),
              GestureDetector(
                onTap: onDelete,
                child: Icon(
                  Icons.delete,
                  size: 16,
                  color: theme.colorScheme.error.withValues(alpha: 0.7),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
