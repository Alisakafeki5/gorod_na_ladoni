import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 40,
            left: 10,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new),
              onPressed: () {
                context.go('/auth-selection');
              },
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/images/logo.svg',
                    height: 90,
                    width: 90,
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () {
                      context.go('/phone-login');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFD5555),
                      foregroundColor: Colors.white,
                      elevation: 5,
                      shadowColor: const Color(0xFF5C5A5A),
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text('Войти по номеру телефона'),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFD5555),
                      foregroundColor: Colors.white,
                      elevation: 5,
                      shadowColor: const Color(0xFF5C5A5A),
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text('Войти через Google'),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFD5555),
                      foregroundColor: Colors.white,
                      elevation: 5,
                      shadowColor: const Color(0xFF5C5A5A),
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text('Войти через Apple'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
