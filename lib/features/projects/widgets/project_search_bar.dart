import 'package:flutter/material.dart';
import 'package:omran/l10n/app_localizations.dart';

class ProjectSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const ProjectSearchBar({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: localizations.searchProjects,
        prefixIcon: const Icon(Icons.search),
        suffixIcon: controller.text.isEmpty
            ? null
            : IconButton(
          onPressed: () {
            controller.clear();
            onChanged('');
          },
          icon: const Icon(Icons.clear),
        ),
      ),
    );
  }
}