import 'package:flutter/material.dart';

class FilterDropdownOverlay extends StatefulWidget {
  final List<String> options;
  final String? selectedValue;
  final void Function(String) onSelected;
  final LayerLink layerLink;
  final double width;
  final VoidCallback onClose;
  final bool showAbove;
  final bool showSearch;
  final String searchPlaceholder;

  const FilterDropdownOverlay({
    super.key,
    required this.options,
    required this.selectedValue,
    required this.onSelected,
    required this.layerLink,
    required this.width,
    required this.onClose,
    this.showAbove = false,
    this.showSearch = false,
    this.searchPlaceholder = 'Search...',
  });

  @override
  State<FilterDropdownOverlay> createState() => _FilterDropdownOverlayState();
}

class _FilterDropdownOverlayState extends State<FilterDropdownOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;
  late TextEditingController _searchController;
  late List<String> _filteredOptions;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _filteredOptions = widget.options;
    _searchController.addListener(_onSearchChanged);

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _slideAnimation = Tween<double>(begin: -10, end: 0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.forward();
  }

  void _onSearchChanged() {
    setState(() {
      _filteredOptions = widget.options
          .where((option) => option
              .toLowerCase()
              .contains(_searchController.text.toLowerCase()))
          .toList();
    });
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _controller.dispose();
    super.dispose();
  }

  Future<void> _close() async {
    await _controller.reverse();
    widget.onClose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    final backgroundColor = colorScheme.surface;
    final borderColor = colorScheme.outlineVariant;
    final textColor = colorScheme.onSurface;
    final selectedBackgroundColor = colorScheme.surfaceContainerHighest;
    final searchFieldColor = Colors.transparent;

    return Stack(
      children: [
        // Modal barrier to close on tap outside
        Positioned.fill(
          child: GestureDetector(
            onTap: _close,
            behavior: HitTestBehavior.translucent,
            child: Container(color: Colors.transparent),
          ),
        ),
        CompositedTransformFollower(
          link: widget.layerLink,
          showWhenUnlinked: false,
          followerAnchor:
              widget.showAbove ? Alignment.bottomLeft : Alignment.topLeft,
          targetAnchor:
              widget.showAbove ? Alignment.topLeft : Alignment.bottomLeft,
          offset: Offset(0, widget.showAbove ? -8 : 8),
          child: Material(
            color: Colors.transparent,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: AnimatedBuilder(
                animation: _slideAnimation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, _slideAnimation.value),
                    child: child,
                  );
                },
                child: Container(
                  width: widget.width,
                  margin: const EdgeInsets.only(top: 8),
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: borderColor),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 12,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.showSearch) ...[
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 4, right: 16, top: 4, bottom: 4),
                          child: TextField(
                            controller: _searchController,
                            autofocus: true,
                            style: textTheme.bodyMedium?.copyWith(color: textColor),
                            decoration: InputDecoration(
                              hintText: widget.searchPlaceholder,
                              hintStyle: textTheme.bodyMedium?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                              ),
                              prefixIcon: Icon(Icons.search_rounded,
                                  size: 20,
                                  color: colorScheme.onSurfaceVariant),
                              filled: true,
                              fillColor: searchFieldColor,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 12),
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                      ],
                      Flexible(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxHeight: 300),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (_filteredOptions.isEmpty)
                                    Padding(
                                      padding: const EdgeInsets.all(24.0),
                                      child: Text(
                                        'No results found',
                                        style: textTheme.bodySmall?.copyWith(
                                          color: colorScheme.onSurfaceVariant,
                                        ),
                                      ),
                                    ),
                                  ..._filteredOptions.map((option) {
                                    final isSelected =
                                        widget.selectedValue == option;
                                    return Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        onTap: () {
                                          widget.onSelected(option);
                                          _close();
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 2),
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 14,
                                          ),
                                          decoration: BoxDecoration(
                                            color: isSelected
                                                ? selectedBackgroundColor
                                                : Colors.transparent,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Text(
                                            option,
                                            style: textTheme.bodyMedium?.copyWith(
                                              fontWeight: isSelected
                                                  ? FontWeight.w600
                                                  : FontWeight.w500,
                                              color: isSelected
                                                  ? textColor
                                                  : colorScheme.onSurfaceVariant,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                  const SizedBox(height: 8),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
