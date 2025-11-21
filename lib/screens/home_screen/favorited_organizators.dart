import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FavoriteOrganizersScreen extends StatefulWidget {
  const FavoriteOrganizersScreen({super.key});

  @override
  State<FavoriteOrganizersScreen> createState() =>
      _FavoriteOrganizersScreenState();
}

class _FavoriteOrganizersScreenState extends State<FavoriteOrganizersScreen> {
  /// Здесь в будущем будут данные из базы
  final List<Organizer> favoriteOrganizers = [
    Organizer(
      firstName: "Анна",
      lastName: "Иванова",
      photoUrl: "https://via.placeholder.com/150",
    ),
    Organizer(
      firstName: "Петр",
      lastName: "Сидоров",
      photoUrl: "https://via.placeholder.com/150",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.grey[800]),
          onPressed: () {
            context.push('/home');
          },
        ),
        title: const Text(
          'Избранные организаторы',
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          /// Две заглушки
          const OrganizerPlaceholder(),
          const OrganizerPlaceholder(),

          const SizedBox(height: 16),

          /// Данные из базы
          if (favoriteOrganizers.isNotEmpty)
            ...favoriteOrganizers.map((o) => OrganizerCard(organizer: o))
          else
            const Center(
              child: Padding(
                padding: EdgeInsets.only(top: 40),
                child: Text(
                  'Добавьте организаторов в избранное',
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// -------------------------
///   МОДЕЛЬ ОРГАНИЗАТОРА
/// -------------------------
class Organizer {
  final String firstName;
  final String lastName;
  final String photoUrl;

  Organizer({
    required this.firstName,
    required this.lastName,
    required this.photoUrl,
  });
}

/// -------------------------
///   КАРТОЧКА ОРГАНИЗАТОРА
/// -------------------------
class OrganizerCard extends StatelessWidget {
  final Organizer organizer;

  const OrganizerCard({super.key, required this.organizer});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),

        leading: ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: Image.network(
            organizer.photoUrl,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(40),
                ),
                child: const Icon(Icons.person, color: Colors.grey),
              );
            },
          ),
        ),

        title: Text(
          '${organizer.firstName} ${organizer.lastName}',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),

        onTap: () {
          context.push('/organizer-profile', extra: organizer);
        },
      ),
    );
  }
}

/// -------------------------
///   ЗАГЛУШКА ДЛЯ 2Х КАРТОЧЕК
/// -------------------------
class OrganizerPlaceholder extends StatelessWidget {
  const OrganizerPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      child: Container(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(40),
              ),
            ),
            const SizedBox(width: 16),
            Container(
              height: 20,
              width: 140,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
