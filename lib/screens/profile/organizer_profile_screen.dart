import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class OrganizerProfileScreen extends StatelessWidget {
  final String name;
  final String phone;
  final String photoUrl;

  const OrganizerProfileScreen({
    super.key,
    required this.name,
    required this.phone,
    required this.photoUrl,
  });

  @override
  Widget build(BuildContext context) {
    final titleStyle = GoogleFonts.alegreyaSansSc(
      fontSize: 28,
      fontWeight: FontWeight.bold,
    );

    final buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF7FC9FE),
      foregroundColor: Colors.white,
      elevation: 5,
      minimumSize: const Size(double.infinity, 50),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
    );

    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: Stack(
        children: [
          // 1. Градиентный фон
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.cyan.shade300, Colors.blue.shade500],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // 2. Белый контейнер с контентом
          Positioned(
            top: 230,
            left: 0,
            right: 0,
            bottom: 0, // Убрали kBottomNavigationBarHeight
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  20,
                  80,
                  20,
                  100,
                ), // Уменьшили отступ снизу
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(name, style: titleStyle),
                    const SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.phone, color: Colors.black87),
                        const SizedBox(width: 8),
                        Text(
                          phone,
                          style: GoogleFonts.alegreyaSansSc(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 40),

                    ElevatedButton(
                      style: buttonStyle,
                      onPressed: () {},
                      child: Text(
                        "События",
                        style: GoogleFonts.alegreyaSansSc(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF6B6B),
                        foregroundColor: Colors.white,
                        elevation: 5,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      onPressed: () {},
                      child: Text(
                        "Добавить в избранное",
                        style: GoogleFonts.alegreyaSansSc(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),

          // 3. Фото организатора
          Positioned(
            top: 140,
            left: 0,
            right: 0,
            child: OrganizerPhoto(photoUrl: photoUrl),
          ),

          // 4. Кнопка назад
          Positioned(
            top: 50,
            left: 20,
            child: GestureDetector(
              onTap: () => context.go('/favorites'),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 10,
                      spreadRadius: 1,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.black87,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white, // Белый фон для навигационной панели
          border: Border(
            top: BorderSide(
              color: Color(0xFFE0E0E0),
              width: 1,
            ), // Легкая серая линия сверху
          ),
        ),
        child: CustomBottomNavigationBar(
          selectedIndex: 3, // Индекс для иконки "Избранное"
        ),
      ),
    );
  }
}

// 📸 СТИЛЬ ФОТО ТАКОЙ ЖЕ КАК В PROFILE SCREEN
class OrganizerPhoto extends StatelessWidget {
  final String photoUrl;

  const OrganizerPhoto({super.key, required this.photoUrl});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        height: 130,
        width: 130,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            border: Border.all(color: Colors.white, width: 5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 12,
                spreadRadius: 2,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(23),
            child: Image.network(photoUrl, fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }
}

// Класс CustomBottomNavigationBar с исправлениями
class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;

  const CustomBottomNavigationBar({super.key, required this.selectedIndex});

  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/event-list');
        break;
      case 1:
        context.go('/attending-events');
        break;
      case 2:
        context.go('/home');
        break;
      case 3:
        context.go('/favorites');
        break;
      case 4:
        context.go('/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: (index) => _onItemTapped(context, index),
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedItemColor: const Color(0xFF7FC9FE),
      unselectedItemColor: const Color(0xFF7FC9FE),
      backgroundColor: Colors.white, // Установили белый фон
      elevation: 0, // УБРАЛИ ТЕНЬ - это главное!
      iconSize: 40,
      items: [
        const BottomNavigationBarItem(
          icon: Icon(Icons.calendar_month),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/images/hands.svg',
            width: 40,
            height: 40,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/images/button.svg',
            width: 40,
            height: 40,
          ),
          label: '',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.star_rounded),
          label: '',
        ),
        const BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
      ],
    );
  }
}
