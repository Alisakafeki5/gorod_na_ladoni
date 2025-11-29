import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

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
      items: [
        const BottomNavigationBarItem(
          icon: Icon(Icons.calendar_month),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/images/hands.svg',
            width: 24,
            height: 24,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/images/button.svg',
            width: 24,
            height: 24,
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
