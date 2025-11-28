import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/widgets/custom_bottom_navigation_bar.dart';

import '../../widgets/event_list_view.dart';
import '../models/event.dart';

class MyEventsScreen extends StatefulWidget {
  const MyEventsScreen({super.key});

  @override
  State<MyEventsScreen> createState() => _MyEventsScreenState();
}

class _MyEventsScreenState extends State<MyEventsScreen> {
  /// Список событий, созданных пользователем
  final List<Event> _myEvents = [
    Event(
      title: 'Название события',
      participants: '15/30',
      cost: '1000 ₽',
      dateTime: '12.12.2024',
      address: 'ул. Пушкина, д. Колотушкина',
      description: 'Описание описание описание',
      imageUrl: 'https://via.placeholder.com/150',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        automaticallyImplyLeading: false,
        title: const Text('Мои события', style: TextStyle(color: Colors.black)),
      ),

      /// ❗ Используем только новый компонент `EventListView`
      body: EventListView(events: _myEvents),

      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/add-event'),
        backgroundColor: const Color(0xFF7FC9FE),
        child: const Icon(Icons.add),
      ),

      bottomNavigationBar: const CustomBottomNavigationBar(selectedIndex: 2),
    );
  }
}
