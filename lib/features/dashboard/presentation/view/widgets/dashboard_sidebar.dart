import 'package:flutter/material.dart';
import 'package:task_track/core/constants/app_colors.dart';
import 'package:task_track/core/widgets/app_logo_widget.dart';

class DashboardSidebar extends StatelessWidget {
  final String selectedItem;
  final Function(String) onItemSelected;

  const DashboardSidebar({
    super.key,
    required this.selectedItem,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? Colors.black : Colors.white;

    return Container(
      width: 260,
      color: bgColor,
      child: Column(
        children: [
          const SizedBox(height: 24),
          const AppLogoWidget(width: 120, height: 120),
          const SizedBox(height: 48),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildMenuItem(context, 'Dashboard', Icons.home_rounded, isDark),
                _buildMenuItem(context, 'Users', Icons.people_outline_rounded, isDark),
                _buildMenuItem(context, 'Departments', Icons.business_outlined, isDark),
                _buildMenuItem(context, 'Services', Icons.build_outlined, isDark),
                _buildMenuItem(context, 'Clients', Icons.person_outline_rounded, isDark),
                _buildMenuItem(context, 'Projects', Icons.folder_open_rounded, isDark),
                _buildMenuItem(context, 'Reports', Icons.bar_chart_rounded, isDark),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    String title,
    IconData icon,
    bool isDark,
  ) {
    final isSelected = selectedItem == title;
    final color = isSelected 
        ? (isDark ? Colors.white : AppColors.primary) 
        : (isDark ? AppColors.textSecondary : Colors.grey.shade600);

    return InkWell(
      onTap: () => onItemSelected(title),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected 
              ? (isDark ? AppColors.logoBoxBackground : AppColors.primary.withValues(alpha: 0.1)) 
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(width: 16),
            Text(
              title,
              style: TextStyle(
                color: color,
                fontSize: 15,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
