import 'package:flutter/material.dart';
import 'package:myapp/widgets/custom_bottom_navigation_bar.dart';

import '../../widgets/event_list_view.dart';
import '../models/event.dart'; // содержит класс Event

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
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        automaticallyImplyLeading: false,
        title: const Text('Я пойду', style: TextStyle(color: Colors.black)),
      ),

      /// ⬇⬇⬇ Используем единую систему отображения
      body: EventListView(events: _events),

      bottomNavigationBar: const CustomBottomNavigationBar(selectedIndex: 1),
    );
  }
}
