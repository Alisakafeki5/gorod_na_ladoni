import 'package:flutter/material.dart';

import '../screens/models/event.dart';
import 'event_card.dart';
import 'event_placeholder.dart';

class EventListView extends StatelessWidget {
  final List<Event> events;

  const EventListView({super.key, required this.events});

  @override
  Widget build(BuildContext context) {
    if (events.isEmpty) {
      return ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) => const EventPlaceholder(),
      );
    }

    return ListView.builder(
      itemCount: events.length,
      itemBuilder: (context, index) {
        return EventCard(event: events[index]);
      },
    );
  }
}
