import 'package:flutter/material.dart';
import 'package:omran/l10n/app_localizations.dart';

class FileCard extends StatelessWidget {
  final String fileName;
  final String fileType;
  final String fileSize;
  final String date;

  const FileCard({
    super.key,
    required this.fileName,
    required this.fileType,
    required this.fileSize,
    required this.date,
  });

  IconData _fileIcon() {
    switch (fileType.toLowerCase()) {
      case 'pdf':
        return Icons.picture_as_pdf_outlined;
      case 'image':
        return Icons.image_outlined;
      case 'doc':
        return Icons.description_outlined;
      default:
        return Icons.insert_drive_file_outlined;
    }
  }

  void _showActionMessage(
      BuildContext context,
      String action,
      ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$action "$fileName"'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Card(
      child: ListTile(
        leading: CircleAvatar(
          child: Icon(_fileIcon()),
        ),
        title: Text(
          fileName,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          '$date · $fileSize',
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            switch (value) {
              case 'open':
                _showActionMessage(
                  context,
                  localizations.opening,
                );
                break;

              case 'download':
                _showActionMessage(
                  context,
                  localizations.downloading,
                );
                break;

              case 'delete':
                _showActionMessage(
                  context,
                  localizations.deleting,
                );
                break;
            }
          },
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 'open',
              child: ListTile(
                leading: const Icon(
                  Icons.open_in_new,
                ),
                title: Text(
                  localizations.openFile,
                ),
              ),
            ),
            PopupMenuItem(
              value: 'download',
              child: ListTile(
                leading: const Icon(
                  Icons.download_outlined,
                ),
                title: Text(
                  localizations.download,
                ),
              ),
            ),
            PopupMenuItem(
              value: 'delete',
              child: ListTile(
                leading: const Icon(
                  Icons.delete_outline,
                ),
                title: Text(
                  localizations.delete,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}