import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/diagnostics_screen.dart';
import 'screens/guidance_screen.dart';
import 'screens/tracking_screen.dart';
import 'screens/reminders_screen.dart';
import 'screens/user_profile_screen.dart';

class ThusoVhathuniApp extends StatelessWidget {
  const ThusoVhathuniApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ThusoVhathuni',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2E7D32), // Deep green
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        cardTheme: CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/diagnostics': (context) => const DiagnosticsScreen(),
        '/guidance': (context) => const GuidanceScreen(),
        '/tracking': (context) => const TrackingScreen(),
        '/reminders': (context) => const RemindersScreen(),
        '/profile': (context) => const UserProfileScreen(),
      },
    );
  }
}


