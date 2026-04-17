import 'package:flutter/material.dart';
import 'package:task_track/features/dashboard/presentation/view/widgets/filter_dropdown_overlay.dart';

class TaskFilterField extends StatefulWidget {
  final String label;
  final String hint;
  final bool isDark;
  final IconData? icon;
  final IconData? prefixIcon;
  final double width;
  final List<String>? options;
  final String? value;
  final void Function(String)? onChanged;
  final bool showSearch;
  final String? searchPlaceholder;

  const TaskFilterField({
    super.key,
    required this.label,
    required this.hint,
    required this.isDark,
    this.icon,
    this.prefixIcon,
    this.width = 200,
    this.options,
    this.value,
    this.onChanged,
    this.showSearch = false,
    this.searchPlaceholder,
  });

  @override
  State<TaskFilterField> createState() => _TaskFilterFieldState();
}

class _TaskFilterFieldState extends State<TaskFilterField> {
  final LayerLink _layerLink = LayerLink();
  final OverlayPortalController _overlayController = OverlayPortalController();
  String? _selectedOption;

  @override
  void initState() {
    super.initState();
    _selectedOption = widget.value;
  }

  @override
  void didUpdateWidget(covariant TaskFilterField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      _selectedOption = widget.value;
    }
  }

  void _toggleDropdown() {
    if (widget.options == null) return;
    _overlayController.toggle();
  }

  void _hideDropdown() {
    _overlayController.hide();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    final displayText = _selectedOption ?? widget.hint;
    final isHint = _selectedOption == null;

    final fieldBackground = colorScheme.surface;
    final borderColor = colorScheme.outlineVariant;
    final labelColor = colorScheme.onSurface;
    final textColor =
        isHint ? colorScheme.onSurfaceVariant : colorScheme.onSurface;

    return CompositedTransformTarget(
      link: _layerLink,
      child: OverlayPortal(
        controller: _overlayController,
        overlayChildBuilder: (context) {
          RenderBox renderBox =
              this.context.findRenderObject() as RenderBox;
          var size = renderBox.size;
          var offset = renderBox.localToGlobal(Offset.zero);
          var screenHeight = MediaQuery.of(context).size.height;

          // Estimate dropdown height: items count * approx height + search/padding
          final double itemsHeight = (widget.options!.length * 52.0);
          final double extraHeight = widget.showSearch ? 60.0 : 16.0;
          final double dropdownHeight = itemsHeight + extraHeight;
          
          bool showAbove =
              (offset.dy + size.height + dropdownHeight) > screenHeight;

          return FilterDropdownOverlay(
            options: widget.options!,
            selectedValue: _selectedOption,
            onSelected: (newValue) {
              setState(() {
                _selectedOption = newValue;
              });
              if (widget.onChanged != null) {
                widget.onChanged!(newValue);
              }
            },
            layerLink: _layerLink,
            width: size.width,
            onClose: _hideDropdown,
            showAbove: showAbove,
            showSearch: widget.showSearch,
            searchPlaceholder: widget.searchPlaceholder ?? 'Search...',
          );
        },
        child: SizedBox(
          width: widget.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.label,
                style: textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: labelColor,
                ),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: _toggleDropdown,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  decoration: BoxDecoration(
                    color: fieldBackground,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: borderColor,
                    ),
                  ),
                  child: Row(
                    children: [
                      if (widget.prefixIcon != null) ...[
                        Icon(widget.prefixIcon,
                            size: 16, color: colorScheme.onSurfaceVariant),
                        const SizedBox(width: 8),
                      ],
                      Expanded(
                        child: Text(
                          displayText,
                          style: textTheme.bodySmall?.copyWith(
                            fontWeight:
                                isHint ? FontWeight.normal : FontWeight.w500,
                            color: textColor,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Icon(widget.icon ?? Icons.keyboard_arrow_down_rounded,
                          size: 16, color: colorScheme.onSurfaceVariant),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
