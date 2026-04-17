import 'package:flutter/material.dart';

class UserPaginationWidget extends StatelessWidget {
  final int currentPage;
  final int itemsPerPage;
  final int totalResults;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  const UserPaginationWidget({
    super.key,
    required this.currentPage,
    required this.itemsPerPage,
    required this.totalResults,
    required this.onPrevious,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    final start = totalResults == 0 ? 0 : (currentPage - 1) * itemsPerPage + 1;
    final end = (currentPage * itemsPerPage).clamp(0, totalResults);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Showing $start to $end of $totalResults results',
                style: TextStyle(
                  fontSize: 13,
                  color: isDark ? Colors.white38 : Colors.black38,
                ),
              ),
              Row(
                children: [
                  _PaginationButton(
                    label: 'Previous',
                    isEnabled: currentPage > 1,
                    onTap: onPrevious,
                    isDark: isDark,
                  ),
                  const SizedBox(width: 8),
                  _PaginationButton(
                    label: 'Next',
                    isEnabled: end < totalResults,
                    onTap: onNext,
                    isDark: isDark,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class _PaginationButton extends StatelessWidget {
  final String label;
  final bool isEnabled;
  final VoidCallback onTap;
  final bool isDark;

  const _PaginationButton({
    required this.label,
    required this.isEnabled,
    required this.onTap,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isEnabled ? onTap : null,
      borderRadius: BorderRadius.circular(4),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E293B) : Colors.white,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: isDark ? Colors.white12 : Colors.grey.shade200,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: isEnabled
                ? (isDark ? Colors.white70 : Colors.black87)
                : (isDark ? Colors.white10 : Colors.grey.shade300),
          ),
        ),
      ),
    );
  }
}
