import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';
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
      // --------------------- MAP HERE ---------------------
      FlutterMap(
        options: const MapOptions(
          initialCenter: LatLng(59.9311, 30.3609), // Санкт-Петербург
          initialZoom: 13,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: const ['a', 'b', 'c'],
            userAgentPackageName: 'com.example.myapp',
          ),
        ],
      ),

      // ----------------------------------------------------
      Container(), // Event List
      const Center(child: Text('Add Screen')),
      Container(), // Favorite Organizers
      const Center(child: Text('Profile Screen')),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight + 24),
        child: Container(
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
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 12.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset('assets/images/logo.svg', height: 30),
                  const SizedBox(width: 16),
                  Expanded(child: _buildSearchBar()),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(
                      Icons.notifications_none,
                      color: Colors.black54,
                      size: 30,
                    ),
                    onPressed: () {},
                    tooltip: 'Уведомления',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: IndexedStack(index: _selectedIndex, children: screenContent),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
      ),
    );
  }

  Widget _buildSearchBar() {
    const a = Color(0xFF89CFF0);

    return Container(
      height: 45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: 'Поиск...',
          hintStyle: GoogleFonts.alegreyaSansSc(
            color: Colors.grey[500],
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          prefixIcon: const Icon(Icons.search, color: a, size: 24),
          suffixIcon: IntrinsicHeight(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const VerticalDivider(
                  color: a,
                  thickness: 1,
                  indent: 12,
                  endIndent: 12,
                ),
                IconButton(
                  padding: const EdgeInsets.only(right: 12.0),
                  icon: const Icon(Icons.tune, color: a, size: 24),
                  onPressed: () {},
                  tooltip: 'Фильтры',
                ),
              ],
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: const BorderSide(color: a, width: 1.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: const BorderSide(color: a, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: const BorderSide(color: a, width: 2.0),
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 0,
            horizontal: 20,
          ),
        ),
      ),
    );
  }
}
