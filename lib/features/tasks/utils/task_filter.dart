import 'package:omran/core/models/project.dart';
import 'package:omran/core/models/task.dart';

class TaskFilter {
  static List<Task> apply({
    required List<Task> tasks,
    required List<Project> projects,
    required String searchQuery,
    required String status,
    required String date,
    required String project,
    required String location,
    required String priority,
    bool showTodayOnly = false,
    String? projectName,
  }) {
    List<Task> filtered = List.from(tasks);
    if (projectName != null) {
      filtered = filtered.where((task) {
        return projectNameFromId(task.projectId, projects) == projectName;
      }).toList();
    }
    if (showTodayOnly) {
      final today = DateTime.now();
      filtered = filtered.where((task) {
        final isToday = isSameDay(task.dueDate, today);
        final isOpen = task.status != 'Completed';
        return isToday && isOpen;
      }).toList();
    }
    final query = searchQuery.toLowerCase();
    if (query.isNotEmpty) {
      filtered = filtered.where((task) {
        final title = task.title.toLowerCase();
        final taskProject = projectNameFromId(
          task.projectId,
          projects,
        ).toLowerCase();
        final taskLocation = task.location.toLowerCase();
        return title.contains(query) ||
            taskProject.contains(query) ||
            taskLocation.contains(query);
      }).toList();
    }
    if (status == 'Open') {
      filtered = filtered.where((task) {
        return task.status != 'Completed';
      }).toList();
    }
    if (status == 'Completed') {
      filtered = filtered.where((task) {
        return task.status == 'Completed';
      }).toList();
    }
    if (date != 'All') {
      final today = DateTime.now();
      filtered = filtered.where((task) {
        final taskDate = task.dueDate;
        switch (date) {
          case 'Today':
            return isSameDay(taskDate, today);
          case 'Tomorrow':
            final tomorrow = today.add(const Duration(days: 1));
            return isSameDay(taskDate, tomorrow);
          case 'This Week':
            final startOfWeek = today.subtract(
              Duration(days: today.weekday - 1),
            );
            final endOfWeek = startOfWeek.add(const Duration(days: 6));
            return !taskDate.isBefore(startOfWeek) &&
                !taskDate.isAfter(endOfWeek);
          case 'Overdue':
            return taskDate.isBefore(today) && task.status != 'Completed';
          default:
            return true;
        }
      }).toList();
    }
    if (project != 'All') {
      filtered = filtered.where((task) {
        return projectNameFromId(task.projectId, projects) == project;
      }).toList();
    }
    if (location != 'All') {
      filtered = filtered.where((task) {
        return task.location == location;
      }).toList();
    }
    if (priority != 'All') {
      filtered = filtered.where((task) {
        return task.priority == priority;
      }).toList();
    }
    return filtered;
  }

  static String projectNameFromId(String projectId, List<Project> projects) {
    for (final project in projects) {
      if (project.id == projectId) {
        return project.name;
      }
    }
    return 'Unknown project';
  }

  static Project? projectFromName(String projectName, List<Project> projects) {
    for (final project in projects) {
      if (project.name == projectName) {
        return project;
      }
    }
    return null;
  }

  static List<String> projectNames(List<Project> projects) {
    final names = projects.map((project) => project.name).toSet().toList();
    names.sort();
    return names;
  }

  static List<String> locations(List<Project> projects) {
    final locations = projects
        .map((project) => project.location)
        .toSet()
        .toList();
    locations.sort();
    return locations;
  }

  static bool isSameDay(DateTime first, DateTime second) {
    return first.year == second.year &&
        first.month == second.month &&
        first.day == second.day;
  }
}
