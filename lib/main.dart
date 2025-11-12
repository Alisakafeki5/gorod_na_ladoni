
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/screens/onboarding_screen.dart';
import 'package:myapp/screens/splash_screen.dart';
import 'package:myapp/screens/home_screen.dart';
import 'package:myapp/screens/auth/auth_selection_screen.dart';
import 'package:myapp/screens/auth/registration_options_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: GoogleFonts.abhayaLibre().fontFamily,
        textTheme: GoogleFonts.abhayaLibreTextTheme(textTheme).copyWith(
          bodyLarge: const TextStyle(fontWeight: FontWeight.w800),
          bodyMedium: const TextStyle(fontWeight: FontWeight.w800),
          displayLarge: const TextStyle(fontWeight: FontWeight.w800),
          displayMedium: const TextStyle(fontWeight: FontWeight.w800),
          displaySmall: const TextStyle(fontWeight: FontWeight.w800),
          headlineMedium: const TextStyle(fontWeight: FontWeight.w800),
          headlineSmall: const TextStyle(fontWeight: FontWeight.w800),
          titleLarge: const TextStyle(fontWeight: FontWeight.w800),
          titleMedium: const TextStyle(fontWeight: FontWeight.w800),
          titleSmall: const TextStyle(fontWeight: FontWeight.w800),
          labelLarge: const TextStyle(fontWeight: FontWeight.w800),
          labelMedium: const TextStyle(fontWeight: FontWeight.w800),
          labelSmall: const TextStyle(fontWeight: FontWeight.w800),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
    );
  }
}

final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
     GoRoute(
      path: '/auth-selection',
      builder: (context, state) => const AuthSelectionScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
     GoRoute(
      path: '/register-options',
      builder: (context, state) => const RegistrationOptionsScreen(),
    ),
  ],
);
