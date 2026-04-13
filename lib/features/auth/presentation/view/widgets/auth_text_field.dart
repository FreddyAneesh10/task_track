import 'package:flutter/material.dart';
import 'package:task_track/core/constants/app_colors.dart';
import 'package:task_track/core/theme/app_typography.dart';

class AuthTextField extends StatelessWidget {
  final String hint;
  final String? label;
  final TextEditingController? controller;
  final bool obscureText;
  final Widget? suffixIcon;
  final IconData? prefixIcon;
  final double fontSize;
  final String? Function(String?)? validator;

  const AuthTextField({
    super.key,
    required this.hint,
    this.label,
    this.controller,
    this.obscureText = false,
    this.suffixIcon,
    this.prefixIcon,
    this.fontSize = 14,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    final txtColor = isDark ? Colors.white : AppColors.textHeader;
    final labelStyle = AppTypography.label.copyWith(
      color: isDark ? AppColors.textSecondary : AppColors.textSubheader,
      fontWeight: FontWeight.w600,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) ...[
          Text(label!, style: labelStyle),
          const SizedBox(height: 8),
        ],
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          validator: validator,
          style: AppTypography.bodyMedium.copyWith(
            color: txtColor,
            fontSize: fontSize,
          ),
          cursorColor: AppColors.primary,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: isDark ? AppColors.textTertiary : AppColors.textSubheader.withValues(alpha: 0.6),
            ),
            prefixIcon: prefixIcon != null 
                ? Icon(prefixIcon, color: isDark ? AppColors.textTertiary : AppColors.textSubheader, size: 20) 
                : null,
            suffixIcon: suffixIcon,
          ),
        ),
      ],
    );
  }
}
