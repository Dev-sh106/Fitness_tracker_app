import 'package:flutter/material.dart';
import 'screens/main_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/about_screen.dart';
import 'screens/tip_detail_screen.dart';

void main() {
  runApp(const FitnessTrackerApp());
}

class FitnessTrackerApp extends StatelessWidget {
  const FitnessTrackerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fitness Tracker & BMI Analyzer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1E88E5), // Blue
          primary: const Color(0xFF1E88E5),
          secondary: const Color(0xFFFF9800), // Orange
          surface: Colors.white,
          background: const Color(0xFFF5F5F5),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(fontFamily: 'Roboto'),
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          backgroundColor: Color(0xFF1E88E5),
          foregroundColor: Colors.white,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFFFF9800),
          foregroundColor: Colors.white,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MainScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/about': (context) => const AboutScreen(),
        '/tip_detail': (context) => const TipDetailScreen(),
      },
    );
  }
}
