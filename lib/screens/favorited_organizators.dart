import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/widgets/custom_bottom_navigation_bar.dart';
import 'package:myapp/widgets/home_appbar_top.dart';

class FavoriteOrganizersScreen extends StatefulWidget {
  const FavoriteOrganizersScreen({super.key});

  @override
  State<FavoriteOrganizersScreen> createState() =>
      _FavoriteOrganizersScreenState();
}

class _FavoriteOrganizersScreenState extends State<FavoriteOrganizersScreen> {
  final List<Organizer> favoriteOrganizers = [
    Organizer(
      firstName: "Анна",
      lastName: "Иванова",
      photoUrl: "https://i.pravatar.cc/150?img=1",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // -----------------------------
      //      УБИРАЕМ APPBar
      // -----------------------------
      appBar: null,

      body: Column(
        children: [
          // -----------------------------
          //      ТВОЙ ВЕРХНИЙ ВИДЖЕТ
          // -----------------------------
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: const HomeAppBarTop(
              searchBar: SizedBox.shrink(), // ПУСТО вместо поиска
            ),
          ),

          // Верхнее преграждение цветом #7FC9FE
          Container(
            height: 2.0,
            color: const Color(0xFF7FC9FE),
            width: double.infinity,
          ),

          // Заголовок "Избранные Организаторы" по центру
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            alignment: Alignment.center,
            child: Text(
              'Избранные Организаторы',
              style: GoogleFonts.alegreyaSansSc(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),

          // Нижнее преграждение цветом #7FC9FE
          Container(
            height: 2.0,
            color: const Color(0xFF7FC9FE),
            width: double.infinity,
          ),

          // -----------------------------
          //           СПИСОК
          // -----------------------------
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
              child: favoriteOrganizers.isNotEmpty
                  ? ListView.builder(
                      itemCount: favoriteOrganizers.length,
                      itemBuilder: (context, index) {
                        return OrganizerCard(
                          organizer: favoriteOrganizers[index],
                        );
                      },
                    )
                  : Center(
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
        ],
      ),

      bottomNavigationBar: const CustomBottomNavigationBar(selectedIndex: 3),
    );
  }
}

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
        context.push(
          '/fav_organizer',
          extra: {
            "name": "${organizer.firstName} ${organizer.lastName}",
            "photo": organizer.photoUrl,
            "phone": "89009090090", // можешь заменить на реальный
          },
        );
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
