import 'package:flutter/material.dart';
import 'package:expense_tracker_app/ui/colors.dart';
import 'package:expense_tracker_app/expense.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // ✅ DARK THEME COLOR SCHEME
  static const kDarkColorScheme = ColorScheme.dark(
    primary: Colors.deepPurple,
    secondary: Colors.tealAccent,
    surface: Color(0xFF1E1E1E),
    background: Color(0xFF121212),
    onPrimary: Colors.white,
    onSurface: Colors.white70,
    onBackground: Colors.white,
  );

  // ✅ LIGHT THEME COLOR SCHEME
  static const kLightColorScheme = ColorScheme.light(
    primary: AppColors.kPrimaryColor,
    secondary: AppColors.kSecondaryColor,
    surface: AppColors.kLightSurface,
    background: AppColors.kLightBackground,
    onSurface: AppColors.kLightText,
    onBackground: AppColors.kLightText,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system, // 🌗 Auto-switch by system setting

      // 🌞 LIGHT THEME
      theme: ThemeData.light().copyWith(
        useMaterial3: true,
        colorScheme: kLightColorScheme,
        scaffoldBackgroundColor: AppColors.kLightBackground,
        cardTheme: const CardThemeData(
          color: AppColors.color6,
          elevation: 4,
          margin: EdgeInsets.symmetric(vertical: 4, horizontal: 2),
        ),
        textTheme: ThemeData.light().textTheme.apply(
          bodyColor: AppColors.darkGrey2,
          displayColor: AppColors.darkGrey2,
        ),
        iconTheme: const IconThemeData(color: AppColors.darkGrey2),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            backgroundColor: Colors.black54,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            textStyle:
            const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),

      // 🌚 DARK THEME
      darkTheme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: kDarkColorScheme,
        scaffoldBackgroundColor: kDarkColorScheme.background,
        cardTheme: const CardThemeData(
          color: AppColors.darkGrey2,
          elevation: 4,
          margin: EdgeInsets.symmetric(vertical: 4, horizontal: 2),
        ),
        textTheme: ThemeData.dark().textTheme.apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
        ),
        iconTheme: const IconThemeData(color: Colors.white70),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            backgroundColor: Colors.white24,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            textStyle:
            const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      home: const Expense(),
    );
  }
}
