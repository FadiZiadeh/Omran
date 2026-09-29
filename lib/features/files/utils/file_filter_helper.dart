import 'package:omran/core/models/file_item.dart';
import 'package:omran/core/models/project.dart';

class FileFilterHelper {
  static String? projectNameFromId(
      String projectId,
      List<Project> projects,
      ) {
    for (final project in projects) {
      if (project.id == projectId) {
        return project.name;
      }
    }

    return null;
  }

  static Project? projectFromName(
      String name,
      List<Project> projects,
      ) {
    for (final project in projects) {
      if (project.name == name) {
        return project;
      }
    }

    return null;
  }

  static List<FileItem> filterFiles({
    required List<FileItem> files,
    required List<Project> projects,
    required String searchQuery,
    required String typeFilter,
    required String projectFilter,
    required String dateFilter,
    String? projectName,
  }) {
    return files.where((file) {
      final fileName = file.name.toLowerCase();
      final query = searchQuery.toLowerCase();

      // Search
      if (query.isNotEmpty && !fileName.contains(query)) {
        return false;
      }

      // File type
      if (typeFilter != 'All') {
        if (typeFilter == 'PDF' &&
            file.type.toLowerCase() != 'pdf') {
          return false;
        }

        if (typeFilter == 'Image' &&
            file.type.toLowerCase() != 'image') {
          return false;
        }

        if (typeFilter == 'Document' &&
            file.type.toLowerCase() != 'document') {
          return false;
        }
      }

      // Project
      final fileProject = projectNameFromId(
        file.projectId,
        projects,
      );

      if (projectFilter != 'All' &&
          fileProject != projectFilter) {
        return false;
      }

      // Project-specific view
      if (projectName != null &&
          fileProject != projectName) {
        return false;
      }

      final today = DateTime.now();

      // Date
      if (dateFilter == 'Today') {
        final sameDay =
            file.createdAt.year == today.year &&
                file.createdAt.month == today.month &&
                file.createdAt.day == today.day;

        if (!sameDay) {
          return false;
        }
      }

      if (dateFilter == 'This Week') {
        final weekStart = DateTime(
          today.year,
          today.month,
          today.day,
        ).subtract(
          Duration(days: today.weekday - 1),
        );

        final weekEnd = weekStart.add(
          const Duration(days: 7),
        );

        if (file.createdAt.isBefore(weekStart) ||
            !file.createdAt.isBefore(weekEnd)) {
          return false;
        }
      }

      if (dateFilter == 'This Month') {
        if (file.createdAt.year != today.year ||
            file.createdAt.month != today.month) {
          return false;
        }
      }

      return true;
    }).toList();
  }

  static Map<String, List<FileItem>> groupFilesByProject({
    required List<FileItem> files,
    required List<Project> projects,
  }) {
    final groupedFiles = <String, List<FileItem>>{};

    for (final project in projects) {
      groupedFiles[project.name] = [];
    }

    for (final file in files) {
      final projectName = projectNameFromId(
        file.projectId,
        projects,
      );

      if (projectName != null &&
          groupedFiles.containsKey(projectName)) {
        groupedFiles[projectName]!.add(file);
      }
    }

    return groupedFiles;
  }
}