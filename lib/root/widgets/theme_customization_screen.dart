import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hello_world/root/theme.dart';
import 'package:hello_world/root/theme_notifier.dart';

class ThemeCustomizationScreen extends StatefulWidget {
  const ThemeCustomizationScreen({super.key});

  @override
  State<ThemeCustomizationScreen> createState() =>
      _ThemeCustomizationScreenState();
}

class _ThemeCustomizationScreenState extends State<ThemeCustomizationScreen> {
  final TextEditingController _themeNameController = TextEditingController();
  Color _primaryColor = Colors.blue;
  Color _secondaryColor = Colors.blue.shade200;
  Color _surfaceColor = Colors.white;
  Color _backgroundColor = Colors.grey.shade50;
  Color _errorColor = Colors.red;
  Brightness _brightness = Brightness.light;

  @override
  void dispose() {
    _themeNameController.dispose();
    super.dispose();
  }

  void _saveCustomTheme() async {
    if (_themeNameController.text.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter a theme name')),
        );
      }
      return;
    }

    final customTheme = CustomThemeData(
      name: _themeNameController.text,
      primaryColor: _primaryColor,
      secondaryColor: _secondaryColor,
      surfaceColor: _surfaceColor,
      backgroundColor: _backgroundColor,
      errorColor: _errorColor,
      brightness: _brightness,
    );

    // Load existing custom themes
    final existingThemes = await ThemeStorage.loadCustomThemes();
    existingThemes.add(customTheme);

    // Save updated themes
    await ThemeStorage.saveCustomThemes(existingThemes);

    // Apply the new theme
    if (mounted) {
      final themeNotifier = Provider.of<ThemeNotifier>(context, listen: false);
      themeNotifier.changeTheme(customTheme.toThemeData());

      // Save current theme name
      await ThemeStorage.saveCurrentTheme(customTheme.name);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Theme "${customTheme.name}" saved and applied!'),
          ),
        );
        Navigator.of(context).pop();
      }
    }
  }

  Widget _buildColorPicker(
    String label,
    Color currentColor,
    Function(Color) onColorChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: currentColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Slider(
                value: (currentColor.r * 255.0).roundToDouble(),
                min: 0,
                max: 255,
                onChanged: (value) {
                  onColorChanged(
                    Color.fromARGB(
                      (currentColor.a * 255.0).round(),
                      value.toInt(),
                      (currentColor.g * 255.0).round(),
                      (currentColor.b * 255.0).round(),
                    ),
                  );
                },
                activeColor: currentColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Create Custom Theme'), elevation: 0),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Theme Name Input
            TextField(
              controller: _themeNameController,
              decoration: const InputDecoration(
                labelText: 'Theme Name',
                hintText: 'Enter a name for your theme',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 32),

            // Brightness Toggle
            Text(
              'Theme Mode',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            SegmentedButton<Brightness>(
              segments: const [
                ButtonSegment<Brightness>(
                  value: Brightness.light,
                  label: Text('Light'),
                  icon: Icon(Icons.light_mode),
                ),
                ButtonSegment<Brightness>(
                  value: Brightness.dark,
                  label: Text('Dark'),
                  icon: Icon(Icons.dark_mode),
                ),
              ],
              selected: {_brightness},
              onSelectionChanged: (Set<Brightness> selected) {
                setState(() {
                  _brightness = selected.first;
                  // Update default colors based on brightness
                  if (_brightness == Brightness.dark) {
                    _surfaceColor = Colors.grey.shade900;
                    _backgroundColor = Colors.grey.shade800;
                  } else {
                    _surfaceColor = Colors.white;
                    _backgroundColor = Colors.grey.shade50;
                  }
                });
              },
            ),
            const SizedBox(height: 32),

            // Color Pickers
            Text(
              'Colors',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),

            _buildColorPicker('Primary Color', _primaryColor, (color) {
              setState(() => _primaryColor = color);
            }),
            const SizedBox(height: 24),

            _buildColorPicker('Secondary Color', _secondaryColor, (color) {
              setState(() => _secondaryColor = color);
            }),
            const SizedBox(height: 24),

            _buildColorPicker('Surface Color', _surfaceColor, (color) {
              setState(() => _surfaceColor = color);
            }),
            const SizedBox(height: 24),

            _buildColorPicker('Background Color', _backgroundColor, (color) {
              setState(() => _backgroundColor = color);
            }),
            const SizedBox(height: 24),

            _buildColorPicker('Error Color', _errorColor, (color) {
              setState(() => _errorColor = color);
            }),
            const SizedBox(height: 48),

            // Preview Section
            Text(
              'Preview',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: _backgroundColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: theme.dividerColor),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: _surfaceColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: _primaryColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Sample Card',
                                style: TextStyle(
                                  color: _brightness == Brightness.light
                                      ? Colors.black87
                                      : Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                'This is how your theme will look',
                                style: TextStyle(
                                  color: _brightness == Brightness.light
                                      ? Colors.black54
                                      : Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _primaryColor,
                            foregroundColor: _brightness == Brightness.light
                                ? Colors.white
                                : Colors.black,
                          ),
                          child: const Text('Primary Button'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: _secondaryColor),
                            foregroundColor: _secondaryColor,
                          ),
                          child: const Text('Secondary'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 48),

            // Save Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saveCustomTheme,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Save Custom Theme'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
