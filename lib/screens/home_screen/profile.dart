import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/widgets/custom_bottom_navigation_bar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final buttonTextStyle = GoogleFonts.alegreyaSansSc(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    );
    final textButtonTextStyle = GoogleFonts.alegreyaSansSc(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: const Color(0xFFFD5555),
    );
    final titleTextStyle = GoogleFonts.alegreyaSansSc(
      fontSize: 28,
      fontWeight: FontWeight.bold,
    );

    return Scaffold(
      backgroundColor: Colors.lightBlue, // Fallback color
      body: Stack(
        children: [
          // Background Gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.cyan.shade300, Colors.blue.shade500],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // White content card
          Positioned(
            top: 200,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    20.0,
                    80.0,
                    20.0,
                    100.0,
                  ), // Added padding for nav bar
                  child: Column(
                    children: [
                      Text('Мёд для ушей', style: titleTextStyle),
                      const SizedBox(height: 40),
                      ElevatedButton(
                        onPressed: () => context.go('/edit_profile'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFD5555),
                          foregroundColor: Colors.white,
                          elevation: 5,
                          shadowColor: const Color(0xFF5C5A5A),
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text('Мой аккаунт', style: buttonTextStyle),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () => context.go('/settings'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFD5555),
                          foregroundColor: Colors.white,
                          elevation: 5,
                          shadowColor: const Color(0xFF5C5A5A),
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text('Настройки', style: buttonTextStyle),
                      ),
                      const SizedBox(height: 20),
                      TextButton(
                        onPressed: () => context.go('/auth-selection'),
                        child: Text('Выйти', style: textButtonTextStyle),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Profile Picture
          const Positioned(top: 140, left: 0, right: 0, child: ProfilePic()),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(selectedIndex: 4),
    );
  }
}

class ProfilePic extends StatelessWidget {
  const ProfilePic({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        height: 120,
        width: 120,
        child: Container(
          decoration: BoxDecoration(
            shape:
                BoxShape.rectangle, // Changed to rectangle for rounded corners
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: Colors.white, width: 4),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: ClipRRect(
            // Clip the image to the rounded corners
            borderRadius: BorderRadius.circular(
              21,
            ), // Inner radius should be slightly less
            child: const Image(
              fit: BoxFit.cover,
              image: NetworkImage(
                "https://i.postimg.cc/0jqKB6mS/Profile-Image.png",
              ),
            ),
          ),
        ),
      ),
    );
  }
}
