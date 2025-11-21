import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/widgets/custom_bottom_navigation_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> screenContent = [
      Container(
        color: Colors.grey[300],
        child: const Center(
          child: Text(
            'Map Placeholder',
            style: TextStyle(fontSize: 24, color: Colors.grey),
          ),
        ),
      ),
      Container(),
      const Center(child: Text('Add Screen')),
      Container(),
      const Center(child: Text('Profile Screen')),
    ];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: SvgPicture.asset('assets/images/logo.svg', height: 30),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: IndexedStack(index: _selectedIndex, children: screenContent),
      bottomNavigationBar: CustomBottomNavigationBar(selectedIndex: _selectedIndex),
    );
  }
}
