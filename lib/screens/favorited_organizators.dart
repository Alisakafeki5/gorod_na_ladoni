import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/widgets/custom_bottom_navigation_bar.dart';

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
      photoUrl: "https://i.pravatar.cc/150?img=1",
    ),
    Organizer(
      firstName: "Петр",
      lastName: "Сидоров",
      photoUrl: "https://i.pravatar.cc/150?img=2",
    ),
    Organizer(
      firstName: "Мария",
      lastName: "Кузнецова",
      photoUrl: "https://i.pravatar.cc/150?img=3",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final titleTextStyle = GoogleFonts.alegreyaSansSc(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );

    return Scaffold(
      backgroundColor: Colors.blue.shade500, // Fallback color
      body: Stack(
        children: [
          // Background Gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.cyan.shade300, Colors.blue.shade500],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // Title
          Positioned(
            top: 60,
            left: 20,
            right: 20,
            child: Text(
              'Избранные организаторы',
              style: titleTextStyle,
              textAlign: TextAlign.center,
            ),
          ),

          // White content card
          Positioned(
            top: 140,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
              ),
              child: favoriteOrganizers.isNotEmpty
                  ? ListView.builder(
                      padding: const EdgeInsets.fromLTRB(16, 24, 16, 100),
                      itemCount: favoriteOrganizers.length,
                      itemBuilder: (context, index) {
                        return OrganizerCard(
                          organizer: favoriteOrganizers[index],
                        );
                      },
                    )
                  : Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: Text(
                          'Добавьте организаторов в избранное',
                          style: GoogleFonts.alegreyaSansSc(
                            color: Colors.grey,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(selectedIndex: 3),
    );
  }
}

/// ------------------------
///   МОДЕЛЬ ОРГАНИЗАТОРА
/// ------------------------
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

/// ------------------------
///   КАРТОЧКА ОРГАНИЗАТОРА
/// ------------------------
class OrganizerCard extends StatelessWidget {
  final Organizer organizer;

  const OrganizerCard({super.key, required this.organizer});

  @override
  Widget build(BuildContext context) {
    final cardTextStyle = GoogleFonts.alegreyaSansSc(
      fontSize: 20,
      fontWeight: FontWeight.w700,
      color: Colors.black87,
    );

    return GestureDetector(
      onTap: () {
        context.push('/organizer-events', extra: organizer);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  organizer.photoUrl,
                  width: 70,
                  height: 70,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Icon(
                        Icons.person,
                        color: Colors.grey.shade400,
                        size: 40,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  '${organizer.firstName} ${organizer.lastName}',
                  style: cardTextStyle,
                ),
              ),
              Icon(Icons.arrow_forward_ios, color: Colors.grey.shade400),
            ],
          ),
        ),
      ),
    );
  }
}
