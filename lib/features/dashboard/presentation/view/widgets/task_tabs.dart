import 'package:flutter/material.dart';

class TaskTabs extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabChanged;

  const TaskTabs({
    super.key,
    required this.selectedIndex,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      children: [
        _buildTab(context, 'Active Tasks', 0, isDark),
        const SizedBox(width: 8),
        _buildTab(context, 'Other Tasks', 1, isDark),
      ],
    );
  }

  Widget _buildTab(BuildContext context, String text, int index, bool isDark) {
    final isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () => onTabChanged(index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? (isDark ? const Color(0xFF1E293B) : Colors.black87)
              : (isDark ? const Color(0xFF0F172A) : Colors.grey.shade200),
          borderRadius: BorderRadius.circular(10),
          border: isSelected && isDark 
              ? Border.all(color: Colors.white24, width: 0.5) 
              : null,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 13,
            color: isSelected
                ? Colors.white
                : (isDark ? Colors.grey.shade500 : Colors.grey.shade600),
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
