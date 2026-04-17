class PaginatedResponse<T> {
  final List<T> items;
  final int total;

  const PaginatedResponse({
    required this.items,
    required this.total,
  });
}
