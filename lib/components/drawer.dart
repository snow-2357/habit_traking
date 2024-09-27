import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:habit_tracking/theme/theme_provider.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider =
        Provider.of<ThemeProvider>(context); // Access ThemeProvider

    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Center(
        child: CupertinoSwitch(
          value: themeProvider
              .isDarkMode, // Current value of the theme (dark/light)
          onChanged: (value) {
            themeProvider
                .toggleTheme(); // Toggle the theme when the switch is changed
          },
        ),
      ),
    );
  }
}
