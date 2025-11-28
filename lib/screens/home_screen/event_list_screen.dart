import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/widgets/custom_bottom_navigation_bar.dart';

import '../../widgets/event_list_view.dart';
import '../models/event.dart'; // <-- добавляем
// event_card.dart и event_placeholder.dart не нужны здесь напрямую

class EventListScreen extends StatefulWidget {
  const EventListScreen({super.key});

  @override
  State<EventListScreen> createState() => _EventListScreenState();
}

class _EventListScreenState extends State<EventListScreen> {
  final List<Event> _events = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight + 24),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          automaticallyImplyLeading: false,
          title: _buildSearchBar(),
          actions: [
            ElevatedButton(
              onPressed: () => context.go('/my-events'),
              style: ElevatedButton.styleFrom(foregroundColor: Colors.white),
              child: const Text('Мои события'),
            ),
          ],
        ),
      ),

      /// ⬇️ Заменено на EventListView
      body: EventListView(events: _events),

      bottomNavigationBar: const CustomBottomNavigationBar(selectedIndex: 1),
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
