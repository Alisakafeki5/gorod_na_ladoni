import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/filter_repository.dart';
import '../models/filter.dart';

class FilterBottomSheet extends StatefulWidget {
  final Set<String> initialFilters;

  const FilterBottomSheet({super.key, this.initialFilters = const {}});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  late Set<String> _selectedFilters;
  late Future<List<Filter>> _filtersFuture;
  final FilterRepository _repository = FilterRepository();

  final TextEditingController _minPriceController = TextEditingController(
    text: '0',
  );
  final TextEditingController _maxPriceController = TextEditingController(
    text: '100000',
  );

  @override
  void initState() {
    super.initState();
    _selectedFilters = Set.from(widget.initialFilters);
    _filtersFuture = _repository.getFilters();
  }

  void _toggleFilter(String filter) {
    setState(() {
      _selectedFilters.contains(filter)
          ? _selectedFilters.remove(filter)
          : _selectedFilters.add(filter);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.9,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFEAF6FF),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          border: Border.all(color: const Color(0xFF7FC9FE), width: 1.5),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _dragHandle(),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                child: _buildHeader(),
              ),

              const Divider(color: Color(0xFF7FC9FE), thickness: 1, height: 16),

              Expanded(
                child: FutureBuilder<List<Filter>>(
                  future: _filtersFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return const Center(child: Text('Ошибка загрузки'));
                    }

                    final filters = snapshot.data ?? [];

                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: filters.length,
                      itemBuilder: (context, index) {
                        final filter = filters[index];

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: filter.title == 'Цена, Р'
                                  ? _buildPriceSection(filter)
                                  : _buildFilterSection(
                                      title: filter.title,
                                      options: filter.options,
                                      isSingleButton: filter.isSingleButton,
                                    ),
                            ),

                            if (index != filters.length - 1) _sectionDivider(),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
              _applyButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _dragHandle() {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 4),
      child: Container(
        width: 40,
        height: 5,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget _sectionDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Divider(color: Color(0xFF7FC9FE), thickness: 1, height: 1),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Text(
          'Фильтры',
          style: GoogleFonts.alumniSans(
            fontSize: 28,
            fontWeight: FontWeight.w700,
          ),
        ),
        const Spacer(),
        TextButton(
          onPressed: () {
            setState(() {
              _selectedFilters.clear();
              _minPriceController.text = '0';
              _maxPriceController.text = '100000';
            });
          },
          child: Text(
            'Очистить',
            style: GoogleFonts.alumniSans(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black54,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: GoogleFonts.alumniSans(
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildFilterSection({
    required String title,
    required List<String> options,
    bool isSingleButton = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!isSingleButton) _buildSectionTitle(title),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: options.map((option) {
            return _buildFilterChip(option, _selectedFilters.contains(option));
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildFilterChip(String option, bool isSelected) {
    return ChoiceChip(
      label: Text(
        option,
        style: GoogleFonts.alumniSans(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: isSelected ? Colors.blue : Colors.black87,
        ),
      ),
      selected: isSelected,
      onSelected: (_) => _toggleFilter(option),
      showCheckmark: false,
      backgroundColor: Colors.white,
      selectedColor: const Color(0xFFD6ECFF),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: isSelected ? Colors.blue : Colors.grey.shade300,
        ),
      ),
    );
  }

  Widget _buildPriceSection(Filter filter) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(filter.title),
        Row(
          children: [
            _priceField(_minPriceController, 'От'),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 6),
              child: Text('—'),
            ),
            _priceField(_maxPriceController, 'До'),
          ],
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: filter.options.map((option) {
            return _buildFilterChip(option, _selectedFilters.contains(option));
          }).toList(),
        ),
      ],
    );
  }

  Widget _priceField(TextEditingController controller, String hint) {
    return Expanded(
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 14,
          ),
        ),
        style: GoogleFonts.alumniSans(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _applyButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: ElevatedButton(
        onPressed: () => Navigator.pop(context, _selectedFilters),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF7FC9FE),
          minimumSize: const Size(double.infinity, 52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        child: Text(
          'Применить',
          style: GoogleFonts.alumniSans(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
