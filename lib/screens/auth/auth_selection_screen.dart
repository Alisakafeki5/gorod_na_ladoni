import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class AuthSelectionScreen extends StatelessWidget {
  const AuthSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/images/logo.svg', height: 90, width: 90),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  context.go('/register-options');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFD5555),
                  foregroundColor: Colors.white,
                  elevation: 5,
                  shadowColor: const Color(0xFF5C5A5A),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('Создать аккаунт'),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  context.go('/login');
                },
                child: const Text('Уже есть аккаунт'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
