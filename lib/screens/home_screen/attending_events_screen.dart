import 'package:flutter/material.dart';
import 'package:myapp/screens/event_detail_screen.dart';
import 'package:myapp/widgets/custom_bottom_navigation_bar.dart';

class AttendingEventsScreen extends StatefulWidget {
  const AttendingEventsScreen({super.key});

  @override
  State<AttendingEventsScreen> createState() => _AttendingEventsScreenState();
}

class _AttendingEventsScreenState extends State<AttendingEventsScreen> {
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
      body: _events.isEmpty
          ? ListView.builder(
              itemCount: 2, // Show 2 placeholders
              itemBuilder: (context, index) => const _EventPlaceholder(),
            )
          : ListView.builder(
              itemCount: _events.length,
              itemBuilder: (BuildContext context, int index) {
                final event = _events[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                event.imageUrl,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    event.title,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${event.participants} · ${event.cost}',
                                    style: TextStyle(color: Colors.grey[600]),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(event.dateTime),
                                  const SizedBox(height: 4),
                                  Text(event.address),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(event.description),
                        const SizedBox(height: 12),
                        Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const EventDetailScreen(),
                                ),
                              );
                              style:
                              ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFFD5555),
                                foregroundColor: Colors.white,
                              );
                            },
                            child: const Text('Подробнее'),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: const CustomBottomNavigationBar(selectedIndex: 2),
    );
  }
}

// Placeholder widget for the loading state
class _EventPlaceholder extends StatelessWidget {
  const _EventPlaceholder();

  Widget _buildPlaceholder(double height, [double? width]) {
    return Container(
      height: height,
      width: width ?? double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(4.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildPlaceholder(20), // Title
                      const SizedBox(height: 6),
                      _buildPlaceholder(14, 150), // Participants & Cost
                      const SizedBox(height: 6),
                      _buildPlaceholder(14, 120), // Date & Time
                      const SizedBox(height: 6),
                      _buildPlaceholder(14), // Address
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildPlaceholder(14), // Description line 1
            const SizedBox(height: 4),
            _buildPlaceholder(14), // Description line 2
            const SizedBox(height: 4),
            _buildPlaceholder(14, 100), // Description line 3
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EventDetailScreen(),
                    ),
                  );
                },
                child: const Text('Подробнее'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Event {
  final String title;
  final String participants;
  final String cost;
  final String dateTime;
  final String address;
  final String description;
  final String imageUrl;

  Event({
    required this.title,
    required this.participants,
    required this.cost,
    required this.dateTime,
    required this.address,
    required this.description,
    required this.imageUrl,
  });
}
