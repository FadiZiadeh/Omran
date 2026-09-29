import 'package:flutter/material.dart';
import 'package:omran/core/models/file_item.dart';
import 'package:omran/features/files/widgets/file_card.dart';
import 'package:omran/l10n/app_localizations.dart';

class FileProjectSection extends StatelessWidget {
  final String projectName;
  final List<FileItem> files;

  const FileProjectSection({
    super.key,
    required this.projectName,
    required this.files,
  });

  String _formatDate(
      DateTime date,
      AppLocalizations localizations,
      ) {
    final months = [
      localizations.jan,
      localizations.feb,
      localizations.mar,
      localizations.apr,
      localizations.may,
      localizations.jun,
      localizations.jul,
      localizations.aug,
      localizations.sep,
      localizations.oct,
      localizations.nov,
      localizations.dec,
    ];

    return '${months[date.month - 1]} ${date.day}';
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          projectName,
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        ...files.map(
              (file) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: FileCard(
              fileName: file.name,
              fileType: file.type,
              fileSize: file.size,
              date: _formatDate(
                file.createdAt,
                localizations,
              ),
            ),
          ),
        ),
      ],
    );
  }
}