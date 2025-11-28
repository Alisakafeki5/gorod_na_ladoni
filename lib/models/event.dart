class Event {
  final String id;
  final String title;
  final String participants;
  final String cost;
  final String dateTime;
  final String address;
  final String description;
  final String imageUrl;

  const Event({
    required this.id,
    required this.title,
    required this.participants,
    required this.cost,
    required this.dateTime,
    required this.address,
    required this.description,
    required this.imageUrl,
  });
}
