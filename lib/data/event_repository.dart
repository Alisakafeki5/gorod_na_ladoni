import '../models/event.dart';

class EventRepository {
  Future<List<Event>> fetchAllEvents() async {
    await Future.delayed(const Duration(milliseconds: 700));
    return _mockEvents;
  }

  Future<List<Event>> fetchFavoriteEvents() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockEvents.take(2).toList(); // пример
  }

  Future<List<Event>> fetchMyEvents() async {
    await Future.delayed(const Duration(milliseconds: 600));
    return _mockEvents.where((e) => e.participants.contains("Я")).toList();
  }
}

// Мок-данные
final List<Event> _mockEvents = [
  Event(
    id: "1",
    title: "Концерт",
    participants: "150 участников",
    cost: "Бесплатно",
    dateTime: "12 марта, 19:00",
    address: "г. Москва, Арбат 12",
    description: "Супер концерт.",
    imageUrl: "https://picsum.photos/200",
  ),
];
