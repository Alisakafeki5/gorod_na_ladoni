class Filter {
  final String title;
  final List<String> options;
  final bool isSingleButton;

  const Filter({
    required this.title,
    required this.options,
    this.isSingleButton = false,
  });
}
