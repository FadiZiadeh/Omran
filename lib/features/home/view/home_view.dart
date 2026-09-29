
import 'package:flutter/material.dart';
import 'package:omran/core/models/project.dart';
import 'package:omran/core/models/task.dart';
import 'package:omran/core/models/user_profile.dart';
import 'package:omran/core/services/project_service.dart';
import 'package:omran/core/services/task_service.dart';
import 'package:omran/features/home/widgets/active_projects_section.dart';
import 'package:omran/features/home/widgets/daily_greeting.dart';
import 'package:omran/features/home/widgets/home_header.dart';
import 'package:omran/features/home/widgets/portfolio_progress_card.dart';
import 'package:omran/features/home/widgets/recent_actions_section.dart';
import 'package:omran/features/home/widgets/todays_focus_card.dart';
import 'package:omran/l10n/app_localizations.dart';


class HomeView extends StatelessWidget {
final UserProfile? user;
final VoidCallback onTasksPressed;
final VoidCallback onProjectsPressed;
final VoidCallback onTaskBoardPressed;

const HomeView({
super.key,
required this.user,
required this.onTasksPressed,
required this.onProjectsPressed,
required this.onTaskBoardPressed,
});

@override
Widget build(BuildContext context) {
final projectService = ProjectService();
final taskService = TaskService();

return Column(
children: [
HomeHeader(
user: user,
),

Expanded(
child: StreamBuilder<List<Project>>(
stream: projectService.getProjects(),
builder: (context, projectSnapshot) {
if (projectSnapshot.hasError) {
return Center(
child: Text(
  AppLocalizations.of(context)!.unableToLoadProjects,
),
);
}

if (projectSnapshot.connectionState ==
ConnectionState.waiting) {
return Center(
child: CircularProgressIndicator(),
);
}

final projects = projectSnapshot.data ?? [];

return StreamBuilder<List<Task>>(
stream: taskService.getTasks(),
builder: (context, taskSnapshot) {
if (taskSnapshot.hasError) {
return Center(
child: Text(
  AppLocalizations.of(context)!.unableToLoadTasks,
),
);
}

if (taskSnapshot.connectionState ==
ConnectionState.waiting) {
return Center(
child: CircularProgressIndicator(),
);
}

final tasks = taskSnapshot.data ?? [];

return SingleChildScrollView(
padding: const EdgeInsets.fromLTRB(
20,
16,
20,
24,
),
child: Column(
crossAxisAlignment:
CrossAxisAlignment.start,
children: [
const SizedBox(height: 8),

DailyGreeting(
user: user,
),

const SizedBox(height: 24),

PortfolioProgressCard(
projects: projects,
),

const SizedBox(height: 16),

TodaysFocusCard(
tasks: tasks,
onTasksPressed: onTasksPressed,
),

const SizedBox(height: 28),

ActiveProjectsSection(
projects: projects,
onViewAllPressed: onProjectsPressed,
),

const SizedBox(height: 28),

RecentActionsSection(
tasks: tasks,
projects: projects,
onTaskBoardPressed:
onTaskBoardPressed,
),
],
),
);
},
);
},
),
),
],
);
}
}

