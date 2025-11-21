import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  String _selectedLanguage = 'English';

  final List<String> _languages = ['English', 'Russian'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        backgroundColor: const Color(0xFFFD5555),
        foregroundColor: Colors.white,
        title: const Text("Settings"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const SizedBox(height: 24.0),

            // Section: Notifications
            _buildSectionHeader("Notifications"),
            _buildNotificationSetting(),

            const SizedBox(height: 24.0),

            // Section: Language
            _buildSectionHeader("Language"),
            _buildLanguageSetting(),

            const SizedBox(height: 40.0),

            // Buttons Row
            _buildButtonsRow(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color(0xFF333333),
        ),
      ),
    );
  }

  Widget _buildNotificationSetting() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFD5555).withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          children: [
            const Icon(
              Icons.notifications_outlined,
              color: Color(0xFFFD5555),
              size: 24,
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Text(
                "Push Notifications",
                style: TextStyle(fontSize: 16, color: Colors.grey[800]),
              ),
            ),
            Switch(
              value: _notificationsEnabled,
              onChanged: (bool value) {
                setState(() {
                  _notificationsEnabled = value;
                });
              },
              activeColor: const Color(0xFFFD5555),
              activeTrackColor: const Color(0xFFFD5555).withOpacity(0.5),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageSetting() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFD5555).withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          children: [
            const Icon(
              Icons.language_outlined,
              color: Color(0xFFFD5555),
              size: 24,
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Text(
                "App Language",
                style: TextStyle(fontSize: 16, color: Colors.grey[800]),
              ),
            ),
            DropdownButton<String>(
              value: _selectedLanguage,
              underline: const SizedBox(),
              borderRadius: BorderRadius.circular(12),
              items: _languages.map((String language) {
                return DropdownMenuItem<String>(
                  value: language,
                  child: Text(language, style: const TextStyle(fontSize: 16)),
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
          ],
        ),
      ),
    );
  }

  Widget _buildButtonsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // Cancel Button
        SizedBox(
          width: 120,
          child: ElevatedButton(
            onPressed: () {
              // Возврат к профилю без сохранения
              context.go('/profile');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(
                context,
              ).textTheme.bodyLarge!.color!.withOpacity(0.08),
              foregroundColor: Colors.grey[800],
              minimumSize: const Size(double.infinity, 48),
              shape: const StadiumBorder(),
            ),
            child: const Text("Cancel"),
          ),
        ),
        const SizedBox(width: 16.0),

        // Save Button
        SizedBox(
          width: 160,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFD5555),
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 48),
              shape: const StadiumBorder(),
            ),
            onPressed: () {
              _saveSettings();
              _showSuccessMessage();
              // После сохранения возвращаемся к профилю
              Future.delayed(const Duration(milliseconds: 1500), () {
                context.go('/profile');
              });
            },
            child: const Text("Save Settings"),
          ),
        ),
      ],
    );
  }

  void _saveSettings() {
    // Логика сохранения настроек
    print("Notifications: $_notificationsEnabled");
    print("Selected language: $_selectedLanguage");
  }

  void _showSuccessMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Settings saved successfully!"),
        backgroundColor: const Color(0xFFFD5555),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
