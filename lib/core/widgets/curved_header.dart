import 'package:flutter/material.dart';

class CurvedHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onBack;
  final VoidCallback? onMenu;
  final Widget? trailing;

  const CurvedHeader({
    super.key,
    required this.title,
    this.onBack,
    this.onMenu,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final topPadding = MediaQuery.of(context).padding.top;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(top: topPadding, left: 8, right: 12, bottom: 18),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: Row(
        children: [
          if (onBack != null)
            IconButton(
              onPressed: onBack,
              icon: const Icon(Icons.arrow_back),
              color: theme.colorScheme.onPrimary,
            ),

          if (onMenu != null)
            IconButton(
              onPressed: onMenu,
              icon: const Icon(Icons.menu),
              color: theme.colorScheme.onPrimary,
            ),

          Expanded(
            child: Text(
              title,
              style: theme.textTheme.headlineSmall?.copyWith(
                color: theme.colorScheme.onPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}
