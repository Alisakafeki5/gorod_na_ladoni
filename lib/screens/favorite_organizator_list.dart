import 'package:flutter/material.dart';

import 'home_screen/favorited_organizators.dart';

class OrganizerEventsScreen extends StatelessWidget {
  final Organizer organizer;

  const OrganizerEventsScreen({super.key, required this.organizer});

  final List<Map<String, String>> mockEvents = const [
    {
      "title": "Мастер-класс по живописи",
      "date": "12 марта, 14:00",
      "location": "ул. Пушкина, 10",
      "image": "",
    },
    {
      "title": "Тренировка по бегу",
      "date": "15 марта, 09:00",
      "location": "Парк Горького",
      "image": "",
    },
    {
      "title": "Лекция по дизайну",
      "date": "20 марта, 18:30",
      "location": "Онлайн",
      "image": "",
    },
  ];

  // Метод для построения карточки события
  Widget _buildEventCard(Map<String, String> event) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        leading: event["image"]!.isEmpty
            ? const CircleAvatar(
                backgroundColor: Colors.grey,
                child: Icon(Icons.event, color: Colors.white),
              )
            : CircleAvatar(backgroundImage: NetworkImage(event["image"]!)),
        title: Text(
          event["title"]!,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Text(event["date"]!), Text(event["location"]!)],
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
      ),
    );
  }

  // Метод для показа диалога подтверждения
  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Подтверждение"),
          content: const Text("Вы хотите добавить новое событие?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Отмена"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Здесь можно добавить логику создания события
              },
              child: const Text("Да"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${organizer.firstName} ${organizer.lastName}"),
        centerTitle: true,
      ),

      body: Column(
        children: [
          const SizedBox(height: 20),

          /// Фото и имя
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(organizer.photoUrl),
          ),

          const SizedBox(height: 12),

          Text(
            "${organizer.firstName} ${organizer.lastName}",
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 20),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: mockEvents.map(_buildEventCard).toList(),
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFFD5555),
        onPressed: () => _showConfirmationDialog(context),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
