import 'package:flutter/material.dart';
import 'screens/main_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/about_screen.dart';
import 'screens/tip_detail_screen.dart';

// Global ValueNotifier for ThemeMode
final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

void main() {
  runApp(const FitnessTrackerApp());
}

class FitnessTrackerApp extends StatelessWidget {
  const FitnessTrackerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (_, ThemeMode currentMode, __) {
        return MaterialApp(
          title: 'Fitness Tracker & BMI Analyzer',
          debugShowCheckedModeBanner: false,
          themeMode: currentMode,
          theme: _buildLightTheme(),
          darkTheme: _buildDarkTheme(),
          initialRoute: '/',
          routes: {
            '/': (context) => const MainScreen(),
            '/profile': (context) => const ProfileScreen(),
            '/settings': (context) => const SettingsScreen(),
            '/about': (context) => const AboutScreen(),
            '/tip_detail': (context) => const TipDetailScreen(),
          },
        );
      },
    );
  }

  ThemeData _buildLightTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.light,
        seedColor: const Color(0xFF2196F3), // Vibrant Blue
        primary: const Color(0xFF2196F3),
        secondary: const Color(0xFFFF4081), // Pinkish Red for pop
        surface: Colors.white,
        background: const Color(0xFFF0F4F8), // Soft cool grayish blue
      ),
      scaffoldBackgroundColor: const Color(0xFFF0F4F8),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 8,
        shadowColor: Colors.black.withValues(alpha: 0.1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(fontFamily: 'Outfit', fontWeight: FontWeight.bold),
        headlineMedium: TextStyle(fontFamily: 'Outfit', fontWeight: FontWeight.bold),
        titleLarge: TextStyle(fontFamily: 'Outfit', fontWeight: FontWeight.w600),
        bodyLarge: TextStyle(fontFamily: 'Inter'),
        bodyMedium: TextStyle(fontFamily: 'Inter'),
      ),
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Color(0xFF1E293B), // Dark slate text for AppBar
        iconTheme: IconThemeData(color: Color(0xFF1E293B)),
        titleTextStyle: TextStyle(
          color: Color(0xFF1E293B),
          fontSize: 22,
          fontWeight: FontWeight.w700,
          fontFamily: 'Outfit',
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color(0xFFFF4081),
        foregroundColor: Colors.white,
        elevation: 6,
      ),
    );
  }

  ThemeData _buildDarkTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.dark,
        seedColor: const Color(0xFF64B5F6),
        primary: const Color(0xFF64B5F6), // Lighter blue for dark mode
        secondary: const Color(0xFFFF80AB), // Lighter pink
        surface: const Color(0xFF1E293B), // Slate dark
        background: const Color(0xFF0F172A), // Very dark slate
      ),
      scaffoldBackgroundColor: const Color(0xFF0F172A),
      cardTheme: CardThemeData(
        color: const Color(0xFF1E293B),
        elevation: 12,
        shadowColor: Colors.black.withValues(alpha: 0.3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(fontFamily: 'Outfit', fontWeight: FontWeight.bold, color: Colors.white),
        headlineMedium: TextStyle(fontFamily: 'Outfit', fontWeight: FontWeight.bold, color: Colors.white),
        titleLarge: TextStyle(fontFamily: 'Outfit', fontWeight: FontWeight.w600, color: Colors.white),
        bodyLarge: TextStyle(fontFamily: 'Inter', color: Colors.white70),
        bodyMedium: TextStyle(fontFamily: 'Inter', color: Colors.white70),
      ),
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.w700,
          fontFamily: 'Outfit',
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color(0xFFFF80AB),
        foregroundColor: Color(0xFF0F172A),
        elevation: 6,
      ),
    );
  }
}
