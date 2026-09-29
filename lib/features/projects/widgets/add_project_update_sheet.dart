import 'package:flutter/material.dart';
import 'package:omran/l10n/app_localizations.dart';

class AddProjectUpdateResult {
  final String message;
  final String type;

  const AddProjectUpdateResult({
    required this.message,
    required this.type,
  });
}

class AddProjectUpdateSheet extends StatefulWidget {
  const AddProjectUpdateSheet({
    super.key,
  });

  @override
  State<AddProjectUpdateSheet> createState() =>
      _AddProjectUpdateSheetState();
}

class _AddProjectUpdateSheetState
    extends State<AddProjectUpdateSheet> {
  final TextEditingController _messageController =
  TextEditingController();

  String _selectedType = 'update';

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  Widget _buildTypeChip({
    required String label,
    required String value,
    required IconData icon,
  }) {
    final selected = _selectedType == value;

    return ChoiceChip(
      label: Text(label),
      avatar: Icon(
        icon,
        size: 18,
      ),
      selected: selected,
      onSelected: (_) {
        setState(() {
          _selectedType = value;
        });
      },
    );
  }

  void _submit() {
    final message =
    _messageController.text.trim();

    if (message.isEmpty) {
      return;
    }

    Navigator.pop(
      context,
      AddProjectUpdateResult(
        message: message,
        type: _selectedType,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final localizations =
    AppLocalizations.of(context)!;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        20,
        8,
        20,
        MediaQuery.of(context).viewInsets.bottom +
            24,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    localizations.addSiteUpdate,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.close),
                ),
              ],
            ),

            const SizedBox(height: 20),

            TextField(
              controller: _messageController,
              maxLines: 5,
              textInputAction:
              TextInputAction.newline,
              decoration: InputDecoration(
                labelText: localizations.update,
                hintText:
                localizations.whatHappenedOnSite,
                alignLabelWithHint: true,
                prefixIcon: const Padding(
                  padding: EdgeInsets.only(
                    bottom: 72,
                  ),
                  child: Icon(
                    Icons.edit_outlined,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            Text(
              localizations.updateType,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildTypeChip(
                  label: localizations.update,
                  value: 'update',
                  icon: Icons.update_outlined,
                ),
                _buildTypeChip(
                  label: localizations.issue,
                  value: 'issue',
                  icon: Icons.warning_amber_outlined,
                ),
                _buildTypeChip(
                  label: localizations.milestone,
                  value: 'milestone',
                  icon: Icons.flag_outlined,
                ),
                _buildTypeChip(
                  label: localizations.followUp,
                  value: 'follow_up',
                  icon: Icons.push_pin_outlined,
                ),
              ],
            ),

            const SizedBox(height: 28),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submit,
                child: Text(
                  localizations.postUpdate,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}