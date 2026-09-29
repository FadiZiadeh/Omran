import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:omran/core/models/project.dart';
import 'package:omran/core/models/task.dart';
import 'package:omran/core/services/project_service.dart';
import 'package:omran/core/services/task_service.dart';
import 'package:omran/core/widgets/curved_header.dart';
import 'package:omran/features/tasks/widgets/task_card.dart';
import 'package:omran/core/models/notification_model.dart';
import 'package:omran/core/notifications/notification_service.dart';
import 'package:omran/features/tasks/utils/task_filter.dart';
import 'package:omran/features/tasks/widgets/task_filter_sheet.dart';
import 'package:omran/features/tasks/widgets/task_filter_chips.dart';
import 'package:omran/features/tasks/widgets/task_search_bar.dart';
import 'package:omran/features/tasks/widgets/create_task_sheet.dart';
import 'package:omran/features/tasks/widgets/edit_task_sheet.dart';
import 'package:omran/features/tasks/widgets/delete_task_dialog.dart';
import 'package:omran/l10n/app_localizations.dart';

class TasksView extends StatefulWidget {
  final bool showTodayOnly;
  final String? projectName;
  final VoidCallback? onMenu;

  const TasksView({
    super.key,
    this.showTodayOnly = false,
    this.projectName,
    this.onMenu,
  });

  @override
  State<TasksView> createState() => _TasksViewState();
}

class _TasksViewState extends State<TasksView> {
  final TaskService _taskService = TaskService();
  final ProjectService _projectService = ProjectService();
  final NotificationService _notificationService = NotificationService();

  final TextEditingController _searchController = TextEditingController();

  String _searchQuery = '';

  String _statusFilter = 'All';
  String _dateFilter = 'All';
  String _projectFilter = 'All';
  String _locationFilter = 'All';
  String _priorityFilter = 'All';

  String _formatDueDate(
      DateTime date,
      AppLocalizations localizations,
      ) {
    final today = DateTime.now();

    if (TaskFilter.isSameDay(date, today)) {
      return localizations.today;
    }

    final tomorrow = today.add(const Duration(days: 1));

    if (TaskFilter.isSameDay(date, tomorrow)) {
      return localizations.tomorrow;
    }

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

  Future<void> _toggleTask(
      Task task,
      List<Project> projects,
      ) async {
    final project = projects.firstWhere(
          (item) => item.id == task.projectId,
      orElse: () => projects.first,
    );

    if (project.status == 'Ended') {
      return;
    }

    final newStatus =
    task.status == 'Completed' ? 'Open' : 'Completed';

    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      return;
    }

    try {
      await _taskService.updateTask(
        Task(
          id: task.id,
          title: task.title,
          projectId: task.projectId,
          location: task.location,
          status: newStatus,
          priority: task.priority,
          dueDate: task.dueDate,
          assignedTo: task.assignedTo,
          createdAt: task.createdAt,
        ),
      );
    } catch (error) {
      if (!mounted) {
        return;
      }

      final localizations = AppLocalizations.of(context)!;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            localizations.failedToUpdateTask(error.toString()),
          ),
        ),
      );
    }
  }

  Future<void> _showEditTaskSheet(Task task) async {
    final result = await showModalBottomSheet<EditTaskData>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) {
        return EditTaskSheet(task: task);
      },
    );

    if (result == null) {
      return;
    }

    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      if (!mounted) {
        return;
      }

      final localizations = AppLocalizations.of(context)!;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            localizations.mustBeLoggedInToUpdateTask,
          ),
        ),
      );

      return;
    }

    final updatedTask = Task(
      id: task.id,
      title: result.title,
      projectId: task.projectId,
      location: result.location,
      status: result.status,
      priority: result.priority,
      dueDate: result.dueDate,
      assignedTo: result.assignedTo,
      createdAt: task.createdAt,
    );

    try {
      await _taskService.updateTask(updatedTask);

      final localizations = AppLocalizations.of(context)!;

      final notification = NotificationModel(
        id: '',
        userId: currentUser.uid,
        title: localizations.taskUpdated,
        body: localizations.taskWasUpdated(
          updatedTask.title,
        ),
        type: 'task',
        projectId: updatedTask.projectId,
        taskId: updatedTask.id,
        isRead: false,
        createdAt: DateTime.now(),
      );

      await _notificationService.createNotification(
        notification,
      );

      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            localizations.taskUpdatedSuccessfully,
          ),
        ),
      );
    } catch (error) {
      if (!mounted) {
        return;
      }

      final localizations = AppLocalizations.of(context)!;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            localizations.failedToUpdateTask(
              error.toString(),
            ),
          ),
        ),
      );
    }
  }

  Future<void> _deleteTask(Task task) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return DeleteTaskDialog(
          taskTitle: task.title,
        );
      },
    );

    if (shouldDelete != true) {
      return;
    }

    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      return;
    }

    try {
      await _taskService.deleteTask(task.id);

      final localizations = AppLocalizations.of(context)!;

      final notification = NotificationModel(
        id: '',
        userId: currentUser.uid,
        title: localizations.taskDeleted,
        body: localizations.taskWasDeleted(task.title),
        type: 'task',
        projectId: task.projectId,
        taskId: task.id,
        isRead: false,
        createdAt: DateTime.now(),
      );

      await _notificationService.createNotification(
        notification,
      );

      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            localizations.taskDeletedSuccessfully,
          ),
        ),
      );
    } catch (error) {
      if (!mounted) {
        return;
      }

      final localizations = AppLocalizations.of(context)!;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            localizations.failedToDeleteTask(
              error.toString(),
            ),
          ),
        ),
      );
    }
  }

  int _activeFilterCount() {
    int count = 0;

    if (_statusFilter != 'All') {
      count++;
    }

    if (_dateFilter != 'All') {
      count++;
    }

    if (_projectFilter != 'All') {
      count++;
    }

    if (_locationFilter != 'All') {
      count++;
    }

    if (_priorityFilter != 'All') {
      count++;
    }

    return count;
  }

  Future<void> _showFilterSheet(
      List<Project> projects,
      ) async {
    final result = await showModalBottomSheet<TaskFilterValues>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.7,
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(24),
            ),
            child: TaskFilterSheet(
              projects: projects,
              selectedStatus: _statusFilter,
              selectedDate: _dateFilter,
              selectedProject: _projectFilter,
              selectedLocation: _locationFilter,
              selectedPriority: _priorityFilter,
            ),
          ),
        );
      },
    );

    if (result == null) {
      return;
    }

    setState(() {
      _statusFilter = result.status;
      _dateFilter = result.date;
      _projectFilter = result.project;
      _locationFilter = result.location;
      _priorityFilter = result.priority;
    });
  }

  Future<void> _showCreateTaskSheet(
      List<Project> projects,
      ) async {
    Project? selectedProject;

    if (widget.projectName != null) {
      selectedProject = TaskFilter.projectFromName(
        widget.projectName!,
        projects,
      );
    }

    if (selectedProject?.status == 'Ended') {
      selectedProject = null;
    }

    final availableProjects = projects.where((project) {
      return project.status != 'Ended';
    }).toList();

    final result =
    await showModalBottomSheet<CreateTaskData>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) {
        return CreateTaskSheet(
          projects: availableProjects,
          initialProject: selectedProject,
          projectLocked: widget.projectName != null,
        );
      },
    );

    if (result == null) {
      return;
    }

    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      if (!context.mounted) {
        return;
      }

      final localizations = AppLocalizations.of(context)!;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            localizations.mustBeLoggedInToCreateTask,
          ),
        ),
      );

      return;
    }

    try {
      final task = Task(
        id: '',
        title: result.title,
        projectId: result.project.id,
        location: result.project.location,
        status: 'Open',
        priority: result.priority,
        dueDate: result.dueDate,
        assignedTo: currentUser.uid,
        createdAt: DateTime.now(),
      );

      final taskId = await _taskService.addTask(task);

      final localizations = AppLocalizations.of(context)!;

      final notification = NotificationModel(
        id: '',
        userId: currentUser.uid,
        title: localizations.taskCreated,
        body: localizations.newTaskCreated(
          result.title,
          result.project.name,
        ),
        type: 'task',
        projectId: result.project.id,
        taskId: taskId,
        isRead: false,
        createdAt: DateTime.now(),
      );

      await _notificationService.createNotification(
        notification,
      );

      if (!context.mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            localizations.taskCreatedSuccessfully,
          ),
        ),
      );
    } catch (error) {
      if (!context.mounted) {
        return;
      }

      final localizations = AppLocalizations.of(context)!;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            localizations.failedToCreateTask(
              error.toString(),
            ),
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      body: Column(
        children: [
          CurvedHeader(
            title: localizations.tasks,
            onMenu: widget.onMenu,
          ),
          Expanded(
            child: StreamBuilder<List<Project>>(
              stream: _projectService.getProjects(),
              builder: (context, projectSnapshot) {
                if (projectSnapshot.connectionState ==
                    ConnectionState.waiting &&
                    !projectSnapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (projectSnapshot.hasError) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Text(
                        localizations.failedToLoadProjects(
                          projectSnapshot.error.toString(),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }

                final projects = projectSnapshot.data ?? [];

                return StreamBuilder<List<Task>>(
                  stream: _taskService.getTasks(),
                  builder: (context, taskSnapshot) {
                    if (taskSnapshot.connectionState ==
                        ConnectionState.waiting &&
                        !taskSnapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (taskSnapshot.hasError) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Text(
                            localizations.failedToLoadTasks(
                              taskSnapshot.error.toString(),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    }

                    final allTasks = taskSnapshot.data ?? [];

                    final tasks = TaskFilter.apply(
                      tasks: allTasks,
                      projects: projects,
                      searchQuery: _searchQuery,
                      status: _statusFilter,
                      date: _dateFilter,
                      project: _projectFilter,
                      location: _locationFilter,
                      priority: _priorityFilter,
                      showTodayOnly: widget.showTodayOnly,
                      projectName: widget.projectName,
                    );

                    final completedCount = tasks.where((task) {
                      return task.status == 'Completed';
                    }).length;

                    final openCount =
                        tasks.length - completedCount;

                    return SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(
                        20,
                        16,
                        20,
                        100,
                      ),
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.showTodayOnly
                                ? localizations.todaysTasks
                                : widget.projectName == null
                                ? localizations.tasks
                                : '${widget.projectName} ${localizations.tasks}',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.showTodayOnly
                                ? localizations.tasksDueToday
                                : widget.projectName == null
                                ? localizations.keepTrackOfTasks
                                : localizations.projectTasks,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium,
                          ),
                          const SizedBox(height: 24),
                          Row(
                            children: [
                              Expanded(
                                child: TaskSearchBar(
                                  controller: _searchController,
                                  onChanged: (value) {
                                    setState(() {
                                      _searchQuery =
                                          value.trim();
                                    });
                                  },
                                  onClear: () {
                                    _searchController.clear();

                                    setState(() {
                                      _searchQuery = '';
                                    });
                                  },
                                ),
                              ),
                              const SizedBox(width: 7),
                              Stack(
                                children: [
                                  OutlinedButton.icon(
                                    onPressed: () {
                                      _showFilterSheet(
                                        projects,
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.tune,
                                      size: 20,
                                    ),
                                    label: const SizedBox.shrink(),
                                    style:
                                    OutlinedButton.styleFrom(
                                      minimumSize:
                                      const Size(44, 56),
                                      padding: EdgeInsets.zero,
                                      shape:
                                      RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(
                                          14,
                                        ),
                                      ),
                                    ),
                                  ),
                                  if (_activeFilterCount() > 0)
                                    Positioned(
                                      right: 0,
                                      top: 0,
                                      child: Container(
                                        padding:
                                        const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          shape:
                                          BoxShape.circle,
                                        ),
                                        child: Text(
                                          '${_activeFilterCount()}',
                                          style: TextStyle(
                                            color: Theme.of(
                                              context,
                                            )
                                                .colorScheme
                                                .onPrimary,
                                            fontSize: 10,
                                            fontWeight:
                                            FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          Row(
                            children: [
                              Expanded(
                                child: Card(
                                  child: Padding(
                                    padding:
                                    const EdgeInsets.all(16),
                                    child: Column(
                                      children: [
                                        Text(
                                          '$openCount',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineMedium
                                              ?.copyWith(
                                            fontWeight:
                                            FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          localizations.open,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Card(
                                  child: Padding(
                                    padding:
                                    const EdgeInsets.all(16),
                                    child: Column(
                                      children: [
                                        Text(
                                          '$completedCount',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineMedium
                                              ?.copyWith(
                                            fontWeight:
                                            FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          localizations.completed,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          TaskFilterChips(
                            status: _statusFilter,
                            date: _dateFilter,
                            project: _projectFilter,
                            location: _locationFilter,
                            priority: _priorityFilter,
                            onClearStatus: () {
                              setState(() {
                                _statusFilter = 'All';
                              });
                            },
                            onClearDate: () {
                              setState(() {
                                _dateFilter = 'All';
                              });
                            },
                            onClearProject: () {
                              setState(() {
                                _projectFilter = 'All';
                              });
                            },
                            onClearLocation: () {
                              setState(() {
                                _locationFilter = 'All';
                              });
                            },
                            onClearPriority: () {
                              setState(() {
                                _priorityFilter = 'All';
                              });
                            },
                            onClearAll: () {
                              setState(() {
                                _statusFilter = 'All';
                                _dateFilter = 'All';
                                _projectFilter = 'All';
                                _locationFilter = 'All';
                                _priorityFilter = 'All';
                              });
                            },
                          ),
                          const SizedBox(height: 20),
                          if (tasks.isEmpty)
                            Center(
                              child: Padding(
                                padding:
                                const EdgeInsets.all(32),
                                child: Text(
                                  localizations.noTasksFound,
                                ),
                              ),
                            )
                          else
                            ...tasks.map((task) {
                              final project =
                              projects.firstWhere(
                                    (project) =>
                                project.id ==
                                    task.projectId,
                                orElse: () => Project(
                                  id: '',
                                  name: localizations
                                      .unknownProject,
                                  location: '',
                                  status: '',
                                  progress: 0,
                                  dueDate: DateTime.now(),
                                  ownerId: '',
                                  createdAt: DateTime.now(),
                                ),
                              );

                              final isReadOnly =
                                  project.status == 'Ended';

                              return Padding(
                                padding:
                                const EdgeInsets.only(
                                  bottom: 12,
                                ),
                                child: TaskCard(
                                  title: task.title,
                                  project: project.name,
                                  dueDate: _formatDueDate(
                                    task.dueDate,
                                    localizations,
                                  ),
                                  priority: task.priority,
                                  isCompleted:
                                  task.status == 'Completed',
                                  isReadOnly: isReadOnly,
                                  onChanged: (_) {
                                    _toggleTask(
                                      task,
                                      projects,
                                    );
                                  },
                                  onEdit: () {
                                    _showEditTaskSheet(task);
                                  },
                                  onDelete: () {
                                    _deleteTask(task);
                                  },
                                ),
                              );
                            }),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton:
      FloatingActionButton.extended(
        onPressed: () async {
          final projects =
          await _projectService.getProjects().first;

          if (!context.mounted) {
            return;
          }

          if (widget.projectName != null) {
            final project = TaskFilter.projectFromName(
              widget.projectName!,
              projects,
            );

            if (project?.status == 'Ended') {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    localizations
                        .tasksCannotBeAddedToEndedProject,
                  ),
                ),
              );
              return;
            }
          }

          _showCreateTaskSheet(projects);
        },
        icon: const Icon(Icons.add_task),
        label: Text(localizations.addTask),
      ),
    );
  }
}