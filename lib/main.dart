import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/screens/auth/auth_selection_screen.dart';
import 'package:myapp/screens/auth/login_screen.dart';
import 'package:myapp/screens/auth/phone_login_screen.dart';
import 'package:myapp/screens/auth/phone_registration_screen.dart';
import 'package:myapp/screens/auth/phone_verification_screen.dart';
import 'package:myapp/screens/auth/registration_options_screen.dart';
import 'package:myapp/screens/favorite_organizator_list.dart';
import 'package:myapp/screens/favorited_organizators.dart';
import 'package:myapp/screens/home_screen/attending_events_screen.dart';
import 'package:myapp/screens/home_screen/event_list_screen.dart' hide Event;
import 'package:myapp/screens/home_screen/home_screen.dart';
import 'package:myapp/screens/home_screen/profile.dart';
import 'package:myapp/screens/my_events/edit_event.dart';
import 'package:myapp/screens/my_events/my_events.dart';
import 'package:myapp/screens/my_events/new_event.dart';
import 'package:myapp/screens/onboarding_screen.dart';
import 'package:myapp/screens/profile/edit_profile.dart';
import 'package:myapp/screens/profile/settings.dart';

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
          bodyLarge: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
          bodyMedium: const TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 16,
          ),
          displayLarge: const TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 60,
          ),
          displayMedium: const TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 48,
          ),
          displaySmall: const TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 38,
          ),
          headlineMedium: const TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 36,
          ),
          headlineSmall: const TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 26,
          ),
          titleLarge: const TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 24,
          ),
          titleMedium: const TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 18,
          ),
          titleSmall: const TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 16,
          ),
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
  initialLocation: '/home',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
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
      path: '/attending-events',
      builder: (context, state) => const AttendingEventsScreen(),
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
    GoRoute(
      path: '/my-events',
      builder: (context, state) => const MyEventsScreen(),
    ),
    GoRoute(
      path: '/add-event',
      builder: (context, state) => const AddEventScreen(),
    ),
    GoRoute(
      path: '/edit-event',
      builder: (context, state) {
        final event = state.extra as Event;
        return EditEventScreen(event: event);
      },
    ),
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
    GoRoute(
      path: '/phone-login',
      builder: (context, state) => const PhoneLoginScreen(),
    ),
  ],
);
