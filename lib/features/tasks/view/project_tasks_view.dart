import 'package:flutter/material.dart';
import 'package:omran/core/models/task.dart';
import 'package:omran/core/services/task_service.dart';
import 'package:omran/core/widgets/curved_header.dart';
import 'package:omran/features/tasks/widgets/task_card.dart';
import 'package:omran/l10n/app_localizations.dart';

class ProjectTasksView extends StatefulWidget {
  final String projectId;
  final String projectName;
  final bool isEnded;

  const ProjectTasksView({
    super.key,
    required this.projectId,
    required this.projectName,
    this.isEnded = false,
  });

  @override
  State<ProjectTasksView> createState() => _ProjectTasksViewState();
}

class _ProjectTasksViewState extends State<ProjectTasksView> {
  final TaskService _taskService = TaskService();

  final TextEditingController _searchController =
  TextEditingController();

  String _searchQuery = '';

  List<Task> _filterTasks(List<Task> tasks) {
    if (_searchQuery.isEmpty) {
      return tasks;
    }

    final query = _searchQuery.toLowerCase();

    return tasks.where((task) {
      return task.title.toLowerCase().contains(query);
    }).toList();
  }

  Future<void> _toggleTask(Task task) async {
    if (widget.isEnded) {
      return;
    }

    final updatedTask = Task(
      id: task.id,
      title: task.title,
      projectId: task.projectId,
      location: task.location,
      status: task.status == 'Completed' ? 'Open' : 'Completed',
      priority: task.priority,
      dueDate: task.dueDate,
      assignedTo: task.assignedTo,
      createdAt: task.createdAt,
    );

    await _taskService.updateTask(updatedTask);
  }

  void _showAddTaskMessage() {
    final localizations = AppLocalizations.of(context)!;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          localizations.addingTaskAvailableSoon,
        ),
      ),
    );
  }

  String _formatDueDate(
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

    final now = DateTime.now();

    if (date.year == now.year &&
        date.month == now.month &&
        date.day == now.day) {
      return localizations.today;
    }

    return '${months[date.month - 1]} ${date.day}';
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _showEditTaskSheet(Task task) async {
    final titleController =
    TextEditingController(text: task.title);

    final locationController =
    TextEditingController(text: task.location);

    final assignedToController =
    TextEditingController(text: task.assignedTo);

    String selectedPriority = task.priority;
    String selectedStatus = task.status;
    DateTime selectedDueDate = task.dueDate;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (sheetContext) {
        final localizations = AppLocalizations.of(context)!;

        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 10,
                bottom:
                MediaQuery.of(context).viewInsets.bottom + 20,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      localizations.editTask,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: titleController,
                      decoration: InputDecoration(
                        labelText: localizations.taskTitle,
                        border: const OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 14),
                    TextField(
                      controller: locationController,
                      decoration: InputDecoration(
                        labelText: localizations.location,
                        border: const OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 14),
                    DropdownButtonFormField<String>(
                      initialValue: selectedPriority,
                      decoration: InputDecoration(
                        labelText: localizations.priority,
                        border: const OutlineInputBorder(),
                      ),
                      items: [
                        DropdownMenuItem(
                          value: 'High',
                          child: Text(localizations.high),
                        ),
                        DropdownMenuItem(
                          value: 'Medium',
                          child: Text(localizations.medium),
                        ),
                        DropdownMenuItem(
                          value: 'Low',
                          child: Text(localizations.low),
                        ),
                      ],
                      onChanged: (value) {
                        if (value == null) {
                          return;
                        }

                        setSheetState(() {
                          selectedPriority = value;
                        });
                      },
                    ),
                    const SizedBox(height: 14),
                    DropdownButtonFormField<String>(
                      initialValue: selectedStatus,
                      decoration: InputDecoration(
                        labelText: localizations.status,
                        border: const OutlineInputBorder(),
                      ),
                      items: [
                        DropdownMenuItem(
                          value: 'Open',
                          child: Text(localizations.open),
                        ),
                        DropdownMenuItem(
                          value: 'In Progress',
                          child: Text(localizations.inProgress),
                        ),
                        DropdownMenuItem(
                          value: 'Completed',
                          child: Text(localizations.completed),
                        ),
                      ],
                      onChanged: (value) {
                        if (value == null) {
                          return;
                        }

                        setSheetState(() {
                          selectedStatus = value;
                        });
                      },
                    ),
                    const SizedBox(height: 14),
                    TextField(
                      controller: assignedToController,
                      decoration: InputDecoration(
                        labelText: localizations.assignedTo,
                        border: const OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 14),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(
                        Icons.calendar_today_outlined,
                      ),
                      title: Text(localizations.dueDate),
                      subtitle: Text(
                        _formatDueDate(
                          selectedDueDate,
                          localizations,
                        ),
                      ),
                      trailing: OutlinedButton(
                        onPressed: () async {
                          final pickedDate =
                          await showDatePicker(
                            context: context,
                            initialDate: selectedDueDate,
                            firstDate: DateTime(2020),
                            lastDate: DateTime(2100),
                          );

                          if (pickedDate == null) {
                            return;
                          }

                          setSheetState(() {
                            selectedDueDate = DateTime(
                              pickedDate.year,
                              pickedDate.month,
                              pickedDate.day,
                            );
                          });
                        },
                        child: Text(localizations.change),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: () async {
                          final title =
                          titleController.text.trim();

                          if (title.isEmpty) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(
                              SnackBar(
                                content: Text(
                                  localizations
                                      .pleaseEnterTaskTitle,
                                ),
                              ),
                            );
                            return;
                          }

                          final updatedTask = Task(
                            id: task.id,
                            title: title,
                            projectId: task.projectId,
                            location:
                            locationController.text.trim(),
                            status: selectedStatus,
                            priority: selectedPriority,
                            dueDate: selectedDueDate,
                            assignedTo:
                            assignedToController.text.trim(),
                            createdAt: task.createdAt,
                          );

                          try {
                            await _taskService.updateTask(
                              updatedTask,
                            );

                            if (!mounted) {
                              return;
                            }

                            Navigator.pop(sheetContext);

                            ScaffoldMessenger.of(context)
                                .showSnackBar(
                              SnackBar(
                                content: Text(
                                  localizations
                                      .taskUpdatedSuccessfully,
                                ),
                              ),
                            );
                          } catch (e) {
                            if (!mounted) {
                              return;
                            }

                            ScaffoldMessenger.of(context)
                                .showSnackBar(
                              SnackBar(
                                content: Text(
                                  localizations
                                      .failedToUpdateTask(e.toString()),
                                ),
                              ),
                            );
                          }
                        },
                        child: Text(
                          localizations.saveChanges,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _deleteTask(Task task) async {
    final localizations = AppLocalizations.of(context)!;

    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(localizations.deleteTask),
          content: Text(
            localizations.deleteTaskConfirmation(task.title),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, false);
              },
              child: Text(localizations.cancel),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(dialogContext, true);
              },
              style: FilledButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: Text(localizations.delete),
            ),
          ],
        );
      },
    );

    if (shouldDelete != true) {
      return;
    }

    try {
      await _taskService.deleteTask(task.id);

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
    } catch (e) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            localizations.failedToDeleteTask(e.toString()),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return StreamBuilder<List<Task>>(
      stream: _taskService.getTasksByProject(
        widget.projectId,
      ),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            body: Column(
              children: [
                CurvedHeader(
                  title:
                  '${widget.projectName} ${localizations.tasks}',
                  onBack: () {
                    Navigator.pop(context);
                  },
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      localizations
                          .unableToLoadProjectTasks,
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        if (snapshot.connectionState ==
            ConnectionState.waiting) {
          return Scaffold(
            body: Column(
              children: [
                CurvedHeader(
                  title:
                  '${widget.projectName} ${localizations.tasks}',
                  onBack: () {
                    Navigator.pop(context);
                  },
                ),
                const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ],
            ),
          );
        }

        final allTasks = snapshot.data ?? [];
        final tasks = _filterTasks(allTasks);

        final completedCount = allTasks
            .where(
              (task) => task.status == 'Completed',
        )
            .length;

        final openCount =
            allTasks.length - completedCount;

        return Scaffold(
          body: Column(
            children: [
              CurvedHeader(
                title:
                '${widget.projectName} ${localizations.tasks}',
                onBack: () {
                  Navigator.pop(context);
                },
              ),
              Expanded(
                child: SingleChildScrollView(
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
                      const SizedBox(height: 8),
                      Text(
                        localizations.projectTasks,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        localizations.keepTrackOfTasks,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium,
                      ),
                      if (widget.isEnded) ...[
                        const SizedBox(height: 16),
                        Container(
                          width: double.infinity,
                          padding:
                          const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: Colors.grey.withValues(
                              alpha: 0.10,
                            ),
                            borderRadius:
                            BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.lock_outline,
                                size: 20,
                                color: Colors.grey,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  localizations
                                      .projectTasksReadOnly,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                    fontWeight:
                                    FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                      const SizedBox(height: 24),
                      TextField(
                        controller: _searchController,
                        onChanged: (value) {
                          setState(() {
                            _searchQuery =
                                value.trim();
                          });
                        },
                        decoration: InputDecoration(
                          hintText:
                          localizations.searchTasks,
                          prefixIcon:
                          const Icon(Icons.search),
                          suffixIcon:
                          _searchQuery.isNotEmpty
                              ? IconButton(
                            onPressed: () {
                              _searchController
                                  .clear();

                              setState(() {
                                _searchQuery =
                                '';
                              });
                            },
                            icon: const Icon(
                              Icons.clear,
                            ),
                          )
                              : null,
                          border: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.circular(14),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Expanded(
                            child: Card(
                              child: Padding(
                                padding:
                                const EdgeInsets.all(
                                  16,
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      '$openCount',
                                      style: Theme.of(
                                        context,
                                      )
                                          .textTheme
                                          .headlineMedium
                                          ?.copyWith(
                                        fontWeight:
                                        FontWeight
                                            .bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
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
                                const EdgeInsets.all(
                                  16,
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      '$completedCount',
                                      style: Theme.of(
                                        context,
                                      )
                                          .textTheme
                                          .headlineMedium
                                          ?.copyWith(
                                        fontWeight:
                                        FontWeight
                                            .bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      localizations
                                          .completed,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
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
                        ...tasks.map(
                              (task) {
                            return Padding(
                              padding:
                              const EdgeInsets.only(
                                bottom: 12,
                              ),
                              child: TaskCard(
                                title: task.title,
                                project:
                                widget.projectName,
                                dueDate: _formatDueDate(
                                  task.dueDate,
                                  localizations,
                                ),
                                priority: task.priority,
                                isCompleted:
                                task.status ==
                                    'Completed',
                                isReadOnly:
                                widget.isEnded,
                                onChanged: (_) {
                                  _toggleTask(task);
                                },
                                onEdit: () {
                                  _showEditTaskSheet(task);
                                },
                                onDelete: () {
                                  _deleteTask(task);
                                },
                              ),
                            );
                          },
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          floatingActionButton: widget.isEnded
              ? null
              : FloatingActionButton.extended(
            onPressed: _showAddTaskMessage,
            icon: const Icon(
              Icons.add_task,
            ),
            label: Text(
              localizations.addTask,
            ),
          ),
        );
      },
    );
  }
}