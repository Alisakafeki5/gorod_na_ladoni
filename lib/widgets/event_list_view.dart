import 'package:flutter/material.dart';

import '../screens/models/event.dart';
import 'event_card.dart';
import 'event_placeholder.dart';

class EventListView extends StatelessWidget {
  final List<Event> events;
  final ScrollController? scrollController; // ← добавлен параметр

  const EventListView({
    super.key,
    required this.events,
    this.scrollController, // ← принимаем
  });

  @override
  Widget build(BuildContext context) {
    if (events.isEmpty) {
      return ListView.builder(
        controller: scrollController, // ← передаём
        itemCount: 5,
        itemBuilder: (context, index) => const EventPlaceholder(),
      );
    }

    return ListView.builder(
      controller: scrollController, // ← передаём
      itemCount: events.length,
      itemBuilder: (context, index) {
        return EventCard(event: events[index]);
      },
    );
  }
}
