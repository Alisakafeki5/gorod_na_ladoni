import 'package:flutter/material.dart';

import '../screens/event_detail_screen.dart';
import '../screens/models/event.dart';

class EventPlaceholder extends StatelessWidget {
  const EventPlaceholder({super.key});

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
        padding: const EdgeInsets.all(12),
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
            _buildPlaceholder(14),
            const SizedBox(height: 4),
            _buildPlaceholder(14),
            const SizedBox(height: 4),
            _buildPlaceholder(14, 100),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EventDetailScreen(
                        event: Event(
                          title: '',
                          participants: '',
                          cost: '',
                          dateTime: '',
                          address: '',
                          description: '',
                          imageUrl: '',
                        ),
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFD5555),
                  foregroundColor: Colors.white,
                ),
                child: const Text('Подробнее'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
