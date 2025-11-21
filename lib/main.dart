import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/screens/auth/auth_selection_screen.dart';
import 'package:myapp/screens/auth/phone_registration_screen.dart';
import 'package:myapp/screens/auth/phone_verification_screen.dart';
import 'package:myapp/screens/auth/registration_options_screen.dart';
import 'package:myapp/screens/favorite_organizator_list.dart';
import 'package:myapp/screens/home_screen/event_list_screen.dart';
import 'package:myapp/screens/home_screen/favorited_organizators.dart';
import 'package:myapp/screens/home_screen/home_screen.dart';
import 'package:myapp/screens/home_screen/profile.dart';
import 'package:myapp/screens/onboarding_screen.dart';
import 'package:myapp/screens/profile/edit_profile.dart';
import 'package:myapp/screens/profile/settings.dart';
import 'package:myapp/screens/splash_screen.dart';

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
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
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
    GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: '/auth-selection',
      builder: (context, state) => const AuthSelectionScreen(),
    ),
    GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
    GoRoute(
      path: '/register-options',
      builder: (context, state) => const RegistrationOptionsScreen(),
    ),
    GoRoute(
      path: '/phone-registration',
      builder: (context, state) => const PhoneRegistrationScreen(),
    ),
    GoRoute(
      path: '/phone-verification',
      builder: (context, state) => const PhoneVerificationScreen(),
    ),
    GoRoute(
      path: '/event-list',
      builder: (context, state) => const EventListScreen(),
    ),
    GoRoute(
      path: '/favorites',
      builder: (context, state) => const FavoriteOrganizersScreen(),
    ),
    GoRoute(
      path: '/organizer-profile',
      builder: (context, state) {
        final organizer = state.extra as Organizer;
        return OrganizerEventsScreen(organizer: organizer);
      },
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfileScreen(),
    ),
    GoRoute(
      path: '/edit_profile',
      builder: (context, state) => const EditProfileScreen(),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),
  ],
);

class OrganizerProfileScreen extends StatelessWidget {
  final String name;
  const OrganizerProfileScreen({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/favorites'),
        ),
      ),
      body: Center(child: Text('Профиль $name')),
    );
  }
}
