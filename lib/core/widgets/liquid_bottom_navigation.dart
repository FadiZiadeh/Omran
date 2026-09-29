import 'package:flutter/material.dart';

class LiquidBottomNavigation extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  final List<LiquidNavigationItem> items;

  const LiquidBottomNavigation({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final isRtl = Directionality.of(context) == TextDirection.rtl;

    final activeColor = colorScheme.primary;

    return SafeArea(
      top: false,
      child: Container(
        margin: const EdgeInsets.fromLTRB(12, 0, 12, 10),
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: isDark
              ? colorScheme.surfaceContainerHighest
              : colorScheme.surface,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(
                alpha: isDark ? 0.25 : 0.08,
              ),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
          border: Border.all(
            color: colorScheme.outline.withValues(
              alpha: isDark ? 0.15 : 0.08,
            ),
          ),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final itemWidth = constraints.maxWidth / items.length;

            final visualIndex = isRtl
                ? items.length - 1 - selectedIndex
                : selectedIndex;

            return SizedBox(
              height: 68,
              child: Stack(
                children: [
                  AnimatedAlign(
                    duration: const Duration(milliseconds: 450),
                    curve: Curves.easeOutBack,
                    alignment: Alignment(
                      -1 +
                          (visualIndex *
                              2 /
                              (items.length - 1)),
                      0,
                    ),
                    child: SizedBox(
                      width: itemWidth,
                      height: 56,
                      child: Center(
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 350),
                          curve: Curves.easeOutCubic,
                          width: itemWidth - 12,
                          height: 54,
                          decoration: BoxDecoration(
                            color: activeColor.withValues(
                              alpha: isDark ? 0.22 : 0.12,
                            ),
                            borderRadius: BorderRadius.circular(22),
                            border: Border.all(
                              color: activeColor.withValues(
                                alpha: isDark ? 0.35 : 0.18,
                              ),
                              width: 1,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  Row(
                    textDirection:
                    isRtl ? TextDirection.rtl : TextDirection.ltr,
                    children: List.generate(
                      items.length,
                          (index) {
                        final item = items[index];
                        final isSelected = index == selectedIndex;

                        return Expanded(
                          child: _LiquidNavigationItem(
                            item: item,
                            isSelected: isSelected,
                            activeColor: activeColor,
                            onTap: () {
                              onDestinationSelected(index);
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _LiquidNavigationItem extends StatelessWidget {
  final LiquidNavigationItem item;
  final bool isSelected;
  final Color activeColor;
  final VoidCallback onTap;

  const _LiquidNavigationItem({
    required this.item,
    required this.isSelected,
    required this.activeColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final inactiveColor =
        theme.colorScheme.onSurfaceVariant;

    return Semantics(
      button: true,
      selected: isSelected,
      label: item.label,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        splashColor: activeColor.withValues(alpha: 0.08),
        highlightColor: activeColor.withValues(alpha: 0.04),
        child: SizedBox(
          height: 68,
          child: Center(
            child: AnimatedScale(
              scale: isSelected ? 1.0 : 0.92,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutBack,
              child: AnimatedOpacity(
                opacity: isSelected ? 1.0 : 0.72,
                duration: const Duration(milliseconds: 250),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 250),
                      transitionBuilder: (child, animation) {
                        return ScaleTransition(
                          scale: CurvedAnimation(
                            parent: animation,
                            curve: Curves.easeOutBack,
                          ),
                          child: child,
                        );
                      },
                      child: Icon(
                        isSelected
                            ? item.selectedIcon
                            : item.icon,
                        key: ValueKey(isSelected),
                        size: 21,
                        color: isSelected
                            ? activeColor
                            : inactiveColor,
                      ),
                    ),

                    const SizedBox(height: 3),

                    AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeOutCubic,
                      style: theme.textTheme.labelSmall!.copyWith(
                        fontWeight: isSelected
                            ? FontWeight.w700
                            : FontWeight.w500,
                        color: isSelected
                            ? activeColor
                            : inactiveColor,
                      ),
                      child: Text(
                        item.label,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LiquidNavigationItem {
  final IconData icon;
  final IconData selectedIcon;
  final String label;

  const LiquidNavigationItem({
    required this.icon,
    required this.selectedIcon,
    required this.label,
  });
}