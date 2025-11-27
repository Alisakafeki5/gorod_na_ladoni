import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'favorited_organizators.dart';

class OrganizerEventsScreen extends StatelessWidget {
  final Organizer organizer;

  const OrganizerEventsScreen({super.key, required this.organizer});

  // Mock data for events
  final List<Map<String, String>> mockEvents = const [
    {
      "title": "Мастер-класс по живописи",
      "date": "12 марта, 14:00",
      "location": "ул. Пушкина, 10",
      "image": "https://i.postimg.cc/kGqD8J1w/event-1.png",
    },
    {
      "title": "Тренировка по бегу",
      "date": "15 марта, 09:00",
      "location": "Парк Горького",
      "image": "https://i.postimg.cc/T3sRrF1Z/event-2.png",
    },
    {
      "title": "Лекция по дизайну",
      "date": "20 марта, 18:30",
      "location": "Онлайн",
      "image": "https://i.postimg.cc/QdJLs0r3/event-3.png",
    },
  ];

  Widget _buildEventCard(BuildContext context, Map<String, String> event) {
    final titleStyle = GoogleFonts.alegreyaSansSc(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Colors.black87,
    );
    final subtitleStyle = GoogleFonts.alegreyaSansSc(
      fontSize: 15,
      color: Colors.black54,
    );

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (event["image"]!.isNotEmpty)
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(15),
              ),
              child: Image.network(
                event["image"]!,
                width: double.infinity,
                height: 150,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 150,
                  color: Colors.grey[200],
                  child: const Center(
                    child: Icon(Icons.image_not_supported, color: Colors.grey),
                  ),
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(event["title"]!, style: titleStyle),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 14,
                      color: Colors.grey.shade600,
                    ),
                    const SizedBox(width: 8),
                    Text(event["date"]!, style: subtitleStyle),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 14,
                      color: Colors.grey.shade600,
                    ),
                    const SizedBox(width: 8),
                    Text(event["location"]!, style: subtitleStyle),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final titleTextStyle = GoogleFonts.alegreyaSansSc(
      fontSize: 26,
      fontWeight: FontWeight.bold,
    );

    return Scaffold(
      backgroundColor: Colors.white, // Changed background to white
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Мероприятия',
          style: GoogleFonts.alegreyaSansSc(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              const SizedBox(height: 20),

              // Organizer Info
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.1),
                      spreadRadius: 4,
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        organizer.photoUrl,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      "${organizer.firstName} ${organizer.lastName}",
                      style: titleTextStyle,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Events List
              ...mockEvents.map((e) => _buildEventCard(context, e)).toList(),
            ],
          ),
        ),
      ),
    );
  }
}
