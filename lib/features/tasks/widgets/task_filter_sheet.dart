import 'package:flutter/material.dart';
import 'package:omran/core/models/project.dart';
import 'package:omran/l10n/app_localizations.dart';

class TaskFilterValues {
  final String status;
  final String date;
  final String project;
  final String location;
  final String priority;

  const TaskFilterValues({
    required this.status,
    required this.date,
    required this.project,
    required this.location,
    required this.priority,
  });
}

class TaskFilterSheet extends StatefulWidget {
  final List<Project> projects;
  final String selectedStatus;
  final String selectedDate;
  final String selectedProject;
  final String selectedLocation;
  final String selectedPriority;

  const TaskFilterSheet({
    super.key,
    required this.projects,
    required this.selectedStatus,
    required this.selectedDate,
    required this.selectedProject,
    required this.selectedLocation,
    required this.selectedPriority,
  });

  @override
  State<TaskFilterSheet> createState() => _TaskFilterSheetState();
}

class _TaskFilterSheetState extends State<TaskFilterSheet> {
  late String _statusFilter;
  late String _dateFilter;
  late String _projectFilter;
  late String _locationFilter;
  late String _priorityFilter;

  @override
  void initState() {
    super.initState();

    _statusFilter = widget.selectedStatus;
    _dateFilter = widget.selectedDate;
    _projectFilter = widget.selectedProject;
    _locationFilter = widget.selectedLocation;
    _priorityFilter = widget.selectedPriority;
  }

  List<String> get _projectNames {
    final names = widget.projects
        .map((project) => project.name)
        .toSet()
        .toList();

    names.sort();

    return names;
  }

  List<String> get _locations {
    final locations = widget.projects
        .map((project) => project.location)
        .toSet()
        .toList();

    locations.sort();

    return locations;
  }

  void _clearFilters() {
    setState(() {
      _statusFilter = 'All';
      _dateFilter = 'All';
      _projectFilter = 'All';
      _locationFilter = 'All';
      _priorityFilter = 'All';
    });
  }

  void _applyFilters() {
    Navigator.pop(
      context,
      TaskFilterValues(
        status: _statusFilter,
        date: _dateFilter,
        project: _projectFilter,
        location: _locationFilter,
        priority: _priorityFilter,
      ),
    );
  }

  String _localizedStatus(
      String value,
      AppLocalizations localizations,
      ) {
    switch (value) {
      case 'All':
        return localizations.all;
      case 'Open':
        return localizations.open;
      case 'Completed':
        return localizations.completed;
      default:
        return value;
    }
  }

  String _localizedDate(
      String value,
      AppLocalizations localizations,
      ) {
    switch (value) {
      case 'All':
        return localizations.all;
      case 'Today':
        return localizations.today;
      case 'Tomorrow':
        return localizations.tomorrow;
      case 'This Week':
        return localizations.thisWeek;
      case 'Overdue':
        return localizations.overdue;
      default:
        return value;
    }
  }

  String _localizedPriority(
      String value,
      AppLocalizations localizations,
      ) {
    switch (value) {
      case 'All':
        return localizations.all;
      case 'Low':
        return localizations.low;
      case 'Medium':
        return localizations.medium;
      case 'High':
        return localizations.high;
      default:
        return value;
    }
  }

  List<String> _localizedOptions(
      List<String> options,
      String type,
      AppLocalizations localizations,
      ) {
    return options.map((option) {
      switch (type) {
        case 'status':
          return _localizedStatus(option, localizations);
        case 'date':
          return _localizedDate(option, localizations);
        case 'priority':
          return _localizedPriority(option, localizations);
        default:
          if (option == 'All') {
            return localizations.all;
          }
          return option;
      }
    }).toList();
  }

  Widget _buildFilterSection({
    required String title,
    required List<String> options,
    required String selectedValue,
    required ValueChanged<String> onSelected,
    required String type,
    required AppLocalizations localizations,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: options.map((option) {
            return ChoiceChip(
              label: Text(
                _localizedOptions(
                  [option],
                  type,
                  localizations,
                ).first,
              ),
              selected: selectedValue == option,
              onSelected: (_) {
                onSelected(option);
              },
            );
          }).toList(),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          16,
          16,
          16,
          24,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      localizations.filterTasks,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: _clearFilters,
                    child: Text(localizations.clearAll),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildFilterSection(
                title: localizations.status,
                options: const [
                  'All',
                  'Open',
                  'Completed',
                ],
                selectedValue: _statusFilter,
                type: 'status',
                localizations: localizations,
                onSelected: (value) {
                  setState(() {
                    _statusFilter = value;
                  });
                },
              ),
              _buildFilterSection(
                title: localizations.date,
                options: const [
                  'All',
                  'Today',
                  'Tomorrow',
                  'This Week',
                  'Overdue',
                ],
                selectedValue: _dateFilter,
                type: 'date',
                localizations: localizations,
                onSelected: (value) {
                  setState(() {
                    _dateFilter = value;
                  });
                },
              ),
              _buildFilterSection(
                title: localizations.project,
                options: [
                  'All',
                  ..._projectNames,
                ],
                selectedValue: _projectFilter,
                type: 'project',
                localizations: localizations,
                onSelected: (value) {
                  setState(() {
                    _projectFilter = value;
                  });
                },
              ),
              _buildFilterSection(
                title: localizations.location,
                options: [
                  'All',
                  ..._locations,
                ],
                selectedValue: _locationFilter,
                type: 'location',
                localizations: localizations,
                onSelected: (value) {
                  setState(() {
                    _locationFilter = value;
                  });
                },
              ),
              _buildFilterSection(
                title: localizations.priority,
                options: const [
                  'All',
                  'Low',
                  'Medium',
                  'High',
                ],
                selectedValue: _priorityFilter,
                type: 'priority',
                localizations: localizations,
                onSelected: (value) {
                  setState(() {
                    _priorityFilter = value;
                  });
                },
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _applyFilters,
                  child: Text(localizations.applyFilters),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}