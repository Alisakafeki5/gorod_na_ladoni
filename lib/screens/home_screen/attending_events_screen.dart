import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myapp/widgets/custom_bottom_navigation_bar.dart';

import '../../widgets/event_list_view.dart';
import '../models/event.dart'; // содержит класс Event

class HomeAppBarTop extends StatelessWidget {
  final Widget searchBar;

  const HomeAppBarTop({super.key, required this.searchBar});

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
              onPressed: () {},
              tooltip: 'Уведомления',
            ),
          ],
        ),
      ),
    );
  }
}

class AttendingEventsScreen extends StatefulWidget {
  const AttendingEventsScreen({super.key});

  @override
  State<AttendingEventsScreen> createState() => _AttendingEventsScreenState();
}

class _AttendingEventsScreenState extends State<AttendingEventsScreen> {
  /// События, на которые пользователь записался
  final List<Event> _events = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null, // Убираем старый AppBar
      body: Column(
        children: [
          // Добавляем HomeAppBarTop без поиска
          HomeAppBarTop(
            searchBar: Container(), // Пустой контейнер вместо поиска
          ),

          // Верхнее преграждение цветом #7FC9FE
          Container(
            height: 2.0, // Высота преграждения
            color: const Color(0xFF7FC9FE),
            width: double.infinity,
          ),

          // Заголовок "Мои События" по центру
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            alignment: Alignment.center,
            child: const Text(
              'Мои События',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),

          // Нижнее преграждение цветом #7FC9FE (такое же как сверху)
          Container(
            height: 2.0, // Высота преграждения
            color: const Color(0xFF7FC9FE),
            width: double.infinity,
          ),

          // Используем единую систему отображения
          Expanded(child: EventListView(events: _events)),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(selectedIndex: 1),
    );
  }
}
