import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    // The search icon is at index 1.
    // When tapped, navigate to the EventListScreen.
    if (index == 1) {
      context.go('/event-list');
    } else {
      // For all other tabs, update the state to show the corresponding view.
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Define the widgets for the tabs that are displayed within the HomeScreen.
    final List<Widget> screenContent = [
      // Index 0: Home/Map
      Container(
        color: Colors.grey[300],
        child: const Center(
          child: Text(
            'Map Placeholder',
            style: TextStyle(fontSize: 24, color: Colors.grey),
          ),
        ),
      ),
      // Index 1: Search (This is just a placeholder, as we navigate away)
      Container(),
      // Index 2: Add
      const Center(child: Text('Add Screen')),
      // Index 3: Favorites
      const Center(child: Text('Favorites Screen')),
      // Index 4: Profile
      const Center(child: Text('Profile Screen')),
    ];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: SvgPicture.asset(
          'assets/images/logo.svg',
          height: 30,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      // Use an IndexedStack to preserve the state of the other screens.
      body: IndexedStack(
        index: _selectedIndex,
        children: screenContent,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: const Color(0xFF7FC9FE),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: '',
          ),
        ],
      ),
    );
  }
}
