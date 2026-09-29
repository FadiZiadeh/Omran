import 'package:flutter/material.dart';
import 'package:omran/l10n/app_localizations.dart';

class DeleteTaskDialog extends StatelessWidget {
  final String taskTitle;

  const DeleteTaskDialog({
    super.key,
    required this.taskTitle,
  });

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return AlertDialog(
      title: Text(localizations.deleteTask),
      content: Text(
        localizations.deleteTaskConfirmation(taskTitle),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
          child: Text(localizations.cancel),
        ),
        FilledButton(
          onPressed: () {
            Navigator.pop(context, true);
          },
          style: FilledButton.styleFrom(
            backgroundColor: Colors.red,
          ),
          child: Text(localizations.delete),
        ),
      ],
    );
  }
}