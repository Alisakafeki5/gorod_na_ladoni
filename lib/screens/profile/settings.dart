import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  String _selectedLanguage = 'Russian'; // Default to Russian

  final List<String> _languages = ['English', 'Russian'];

  @override
  Widget build(BuildContext context) {
    final titleTextStyle = GoogleFonts.alegreyaSansSc(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Colors.black87,
    );
    final itemTextStyle = GoogleFonts.alegreyaSansSc(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: Colors.black87,
    );
    final buttonTextStyle = GoogleFonts.alegreyaSansSc(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: Colors.white,
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
            top: 100, // Adjusted top position for a settings screen
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
                  padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 40.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.arrow_back_ios,
                              color: Colors.black54,
                            ),
                            onPressed: () => context.go('/profile'),
                          ),
                          Expanded(
                            child: Center(
                              child: Text('Настройки', style: titleTextStyle),
                            ),
                          ),
                          const SizedBox(width: 48), // Balance the IconButton
                        ],
                      ),
                      const SizedBox(height: 40),

                      // Settings Items
                      _buildSettingItem(
                        icon: Icons.notifications_outlined,
                        text: 'Push-уведомления',
                        textStyle: itemTextStyle,
                        child: Switch(
                          value: _notificationsEnabled,
                          onChanged: (bool value) {
                            setState(() {
                              _notificationsEnabled = value;
                            });
                          },
                          activeColor: const Color(0xFFFD5555),
                          activeTrackColor: const Color(
                            0xFFFD5555,
                          ).withOpacity(0.5),
                          inactiveThumbColor: Colors.grey.shade400,
                          inactiveTrackColor: Colors.grey.shade200,
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildSettingItem(
                        icon: Icons.language_outlined,
                        text: 'Язык приложения',
                        textStyle: itemTextStyle,
                        child: DropdownButton<String>(
                          value: _selectedLanguage,
                          underline: const SizedBox(),
                          iconSize: 28,
                          iconEnabledColor: const Color(0xFFFD5555),
                          borderRadius: BorderRadius.circular(12),
                          items: _languages.map((String language) {
                            return DropdownMenuItem<String>(
                              value: language,
                              child: Text(
                                language,
                                style: itemTextStyle.copyWith(fontSize: 16),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              setState(() {
                                _selectedLanguage = newValue;
                              });
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 60),

                      // Save Button
                      ElevatedButton(
                        onPressed: () => _saveSettings(context),
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
                        child: Text(
                          'Сохранить настройки',
                          style: buttonTextStyle,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String text,
    required TextStyle textStyle,
    required Widget child,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFFFD5555), size: 24),
          const SizedBox(width: 16),
          Expanded(child: Text(text, style: textStyle)),
          child,
        ],
      ),
    );
  }

  void _saveSettings(BuildContext context) {
    // Логика сохранения настроек
    print("Notifications: $_notificationsEnabled");
    print("Selected language: $_selectedLanguage");

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Настройки успешно сохранены!"),
        backgroundColor: const Color(0xFFFD5555),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );

    Future.delayed(const Duration(milliseconds: 1500), () {
      if (context.mounted) {
        context.go('/profile');
      }
    });
  }
}
