import 'package:flutter/material.dart';
import 'package:habit_tracking/theme/dark_mode.dart';
import 'package:habit_tracking/theme/light_mode.dart';
import 'package:habit_tracking/theme/theme_provider.dart';
import 'package:provider/provider.dart';

import 'page/home_page.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => ThemeProvider(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: Provider.of<ThemeProvider>(context).themeData,
        home: const HomePage());
  }
}
