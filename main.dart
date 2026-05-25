import 'package:flutter/material.dart';
import 'package:taskyapp/features/navigation/main_screen.dart';
import 'package:taskyapp/Screens/welcome_screen.dart';
import 'package:taskyapp/core/services/preferences_manager.dart';
import 'package:taskyapp/core/theme/dark_theme.dart';
import 'package:taskyapp/core/theme/light_theme.dart';
import 'package:taskyapp/core/theme/theme_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await PreferencesManager().init();
  ThemeController().init();

  String? username = PreferencesManager().getString('username');

  runApp(MyApp(username: username));
}

class MyApp extends StatelessWidget {
  MyApp({super.key, required this.username});

  final String? username;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeController.themeNotifier,
      builder: (BuildContext context, ThemeMode themeMode, Widget? child) {
        return MaterialApp(
          title: 'Tasky',
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          themeMode: themeMode,
          darkTheme: darkTheme,
          home: username == null ? WelcomeScreen() : MainScreen(),
        );
      },
    );
  }
}
