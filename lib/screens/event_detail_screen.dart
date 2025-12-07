import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'models/event.dart';

class EventDetailScreen extends StatelessWidget {
  final Event event;

  const EventDetailScreen({super.key, required this.event});

  // ———————————————— DIALOGS ————————————————

  void _showConfirmationDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Close',
      barrierColor: Colors.black.withAlpha(128),
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (_, __, ___) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Center(
            child: _buildDialog(context, () {
              Navigator.of(context).pop();
              _showSuccessDialog(context);
            }),
          ),
        );
      },
      transitionBuilder: (_, animation, __, child) =>
          FadeTransition(opacity: animation, child: child),
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Close',
      barrierColor: Colors.black.withAlpha(128),
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (_, __, ___) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Center(child: _buildSuccessDialogContent(context)),
        );
      },
      transitionBuilder: (_, animation, __, child) =>
          FadeTransition(opacity: animation, child: child),
    );
  }

  Widget _buildSuccessDialogContent(BuildContext context) {
    return DialogContainer(
      child: DefaultTextStyle(
        style: GoogleFonts.alegreyaSansSc(fontSize: 16, color: Colors.black),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset('assets/images/hands.svg', height: 60),
            const SizedBox(height: 16),
            Text(
              'Событие добавлено',
              style: GoogleFonts.alegreyaSansSc(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            _redButton(context, 'Ок', () => Navigator.of(context).pop()),
          ],
        ),
      ),
    );
  }

  Widget _buildDialog(BuildContext context, VoidCallback onConfirm) {
    return DialogContainer(
      child: DefaultTextStyle(
        style: GoogleFonts.alegreyaSansSc(fontSize: 16, color: Colors.black),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset('assets/images/hands.svg', height: 60),
            const SizedBox(height: 16),
            Text(
              'Добавить событие?',
              style: GoogleFonts.alegreyaSansSc(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            _redButton(context, 'Добавить', onConfirm),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xFFEEEEEE),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 15,
                ),
              ),
              child: const Text(
                'Отмена',
                style: TextStyle(color: Color(0xFF616161)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ————————— Image —————————
            Stack(
              children: [
                SizedBox(
                  height: 250,
                  width: double.infinity,
                  child: Image.network(
                    event.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        const Icon(Icons.image, size: 100, color: Colors.grey),
                  ),
                ),
                Positioned(
                  top: 40,
                  left: 16,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
              ],
            ),

            // ————————— Content —————————
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTag('Событие', const Color(0xFFFFCDD2), Colors.red),
                  const SizedBox(height: 12),
                  Text(
                    event.title,
                    style: GoogleFonts.alegreyaSansSc(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),

                  _buildInfoCard(),

                  const SizedBox(height: 24),
                  _buildTag('Описание', const Color(0xFFEEEEEE), Colors.black),
                  const SizedBox(height: 12),
                  Text(
                    event.description,
                    style: GoogleFonts.alegreyaSansSc(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // ————————— Bottom Buttons —————————
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: () {},
              style: _buttonStyle(const Color(0xFF81D4FA)),
              child: const Text('В избранное'),
            ),
            ElevatedButton(
              onPressed: () => _showConfirmationDialog(context),
              style: _buttonStyle(const Color(0xFFFD5555)),
              child: const Text('Добавить событие'),
            ),
          ],
        ),
      ),
    );
  }

  // ————————————— ADDITIONAL UI —————————————

  Widget _buildTag(String text, Color bg, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: GoogleFonts.alegreyaSansSc(color: color, fontSize: 12),
      ),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF4F4F4),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _infoRow('Дата и время:', event.dateTime),
            _infoRow('Адрес:', event.address),
            _infoRow('Стоимость:', event.cost),
            _infoRow('Участников:', event.participants),
            _infoRow('Организатор:', 'Не указано'),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.alegreyaSansSc(fontWeight: FontWeight.bold),
          ),
          Text(value, style: GoogleFonts.alegreyaSansSc()),
        ],
      ),
    );
  }

  // ————————— Utility Widgets —————————

  ButtonStyle _buttonStyle(Color bg) => ElevatedButton.styleFrom(
    backgroundColor: bg,
    foregroundColor: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
  );

  Widget _redButton(BuildContext context, String text, VoidCallback onTap) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFFD5555),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
      ),
      child: Text(text),
    );
  }
}

// ————————————— REUSABLE DIALOG WRAPPER —————————————

class DialogContainer extends StatelessWidget {
  final Widget child;

  const DialogContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.82,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(26),
            blurRadius: 7,
            spreadRadius: 5,
          ),
        ],
      ),
      child: child,
    );
  }
}
