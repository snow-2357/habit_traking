import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracking/theme/theme_provider.dart';

import 'package:provider/provider.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Provider.of<ThemeProvider>(context).isDarkMode
                ? Icons.dark_mode
                : Icons.sunny),
            Switch(
                value: Provider.of<ThemeProvider>(context).isDarkMode,
                onChanged: (value) =>
                    Provider.of<ThemeProvider>(context, listen: false)
                        .toggleTheme()),
          ],
        ),
      ),
    );
  }
}
