import 'package:omran/core/models/project.dart';

class ProjectFilter {
static List<Project> apply({
required List<Project> projects,
required String searchQuery,
required String status,
required String progress,
required String location,
required String date,
}) {
final now = DateTime.now();
final query = searchQuery.toLowerCase();

return projects.where((project) {
final matchesSearch =
query.isEmpty ||
project.name.toLowerCase().contains(query) ||
project.location.toLowerCase().contains(query);

final matchesStatus =
status == 'All' ||
project.status == status;

bool matchesProgress = true;

if (progress == 'Not started') {
matchesProgress = project.progress == 0;
} else if (progress == 'In progress') {
matchesProgress =
project.progress > 0 &&
project.progress < 0.75;
} else if (progress == 'Almost complete') {
matchesProgress =
project.progress >= 0.75 &&
project.progress < 1;
} else if (progress == 'Completed') {
matchesProgress = project.progress >= 1;
}

final matchesLocation =
location == 'All' ||
project.location == location;

bool matchesDate = true;

if (date == 'Overdue') {
matchesDate =
project.dueDate.isBefore(now) &&
project.status != 'Ended';
} else if (date == 'This week') {
final weekEnd =
now.add(const Duration(days: 7));

matchesDate =
!project.dueDate.isBefore(now) &&
!project.dueDate.isAfter(weekEnd);
} else if (date == 'This month') {
matchesDate =
project.dueDate.year == now.year &&
project.dueDate.month == now.month;
}

return matchesSearch &&
matchesStatus &&
matchesProgress &&
matchesLocation &&
matchesDate;
}).toList();
}

static List<String> locations(
List<Project> projects,
) {
final locations = projects
    .map((project) => project.location)
    .toSet()
    .toList();

locations.sort();

return locations;
}

static int activeFilterCount({
required String status,
required String progress,
required String location,
required String date,
}) {
int count = 0;

if (status != 'All') {
count++;
}

if (progress != 'All') {
count++;
}

if (location != 'All') {
count++;
}

if (date != 'All') {
count++;
}

return count;
}
}

