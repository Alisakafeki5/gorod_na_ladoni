import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeAppBarTop extends StatelessWidget {
  final Widget searchBar;

  const HomeAppBarTop({super.key, required this.searchBar});

  // Функция для показа уведомлений
  void _showNotificationsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Уведомления',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          content: const SizedBox(
            height: 100,
            child: Center(
              child: Text(
                'Пока уведомлений нет',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Закрыть'),
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          elevation: 10,
          backgroundColor: Colors.white,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset('assets/images/logo.svg', height: 30),
            const SizedBox(width: 16),
            Expanded(child: searchBar),
            const SizedBox(width: 8),
            IconButton(
              icon: const Icon(
                Icons.notifications_none,
                color: Colors.black54,
                size: 30,
              ),
              onPressed: () {
                _showNotificationsDialog(context);
              },
              tooltip: 'Уведомления',
            ),
          ],
        ),
      ),
    );
  }
}
