import 'package:flutter/material.dart';
import 'package:omran/core/models/project.dart';
import 'package:omran/features/projects/utils/project_filter.dart';
import 'package:omran/l10n/app_localizations.dart';

class ProjectFilterSheet extends StatefulWidget {
  final List<Project> projects;

  final String selectedStatus;
  final String selectedProgress;
  final String selectedLocation;
  final String selectedDate;

  const ProjectFilterSheet({
    super.key,
    required this.projects,
    required this.selectedStatus,
    required this.selectedProgress,
    required this.selectedLocation,
    required this.selectedDate,
  });

  @override
  State<ProjectFilterSheet> createState() => _ProjectFilterSheetState();
}

class _ProjectFilterSheetState extends State<ProjectFilterSheet> {
  late String _selectedStatus;
  late String _selectedProgress;
  late String _selectedLocation;
  late String _selectedDate;

  @override
  void initState() {
    super.initState();

    _selectedStatus = widget.selectedStatus;
    _selectedProgress = widget.selectedProgress;
    _selectedLocation = widget.selectedLocation;
    _selectedDate = widget.selectedDate;
  }

  void _clearFilters() {
    setState(() {
      _selectedStatus = 'All';
      _selectedProgress = 'All';
      _selectedLocation = 'All';
      _selectedDate = 'All';
    });
  }

  void _applyFilters() {
    Navigator.pop(
      context,
      ProjectFilterValues(
        status: _selectedStatus,
        progress: _selectedProgress,
        location: _selectedLocation,
        date: _selectedDate,
      ),
    );
  }

  Widget _buildFilterSection({
    required String title,
    required List<String> options,
    required String selectedValue,
    required ValueChanged<String> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: options.map((option) {
            return ChoiceChip(
              label: Text(option),
              selected: selectedValue == option,
              onSelected: (_) {
                onChanged(option);
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  String _localizedStatus(
      String status,
      AppLocalizations localizations,
      ) {
    switch (status) {
      case 'All':
        return localizations.all;
      case 'Planning':
        return localizations.planning;
      case 'On track':
        return localizations.onTrack;
      case 'At risk':
        return localizations.atRisk;
      case 'Ended':
        return localizations.ended;
      default:
        return status;
    }
  }

  String _localizedProgress(
      String progress,
      AppLocalizations localizations,
      ) {
    switch (progress) {
      case 'All':
        return localizations.all;
      case 'Not started':
        return localizations.notStarted;
      case 'In progress':
        return localizations.inProgress;
      case 'Almost complete':
        return localizations.almostComplete;
      case 'Completed':
        return localizations.completed;
      default:
        return progress;
    }
  }

  String _localizedDate(
      String date,
      AppLocalizations localizations,
      ) {
    switch (date) {
      case 'All':
        return localizations.all;
      case 'Overdue':
        return localizations.overdue;
      case 'This week':
        return localizations.thisWeek;
      case 'This month':
        return localizations.thisMonth;
      default:
        return date;
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return FractionallySizedBox(
      heightFactor: 0.7,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            20,
            8,
            20,
            24,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      localizations.filterProjects,
                      style:
                      Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: _clearFilters,
                    child: Text(localizations.clear),
                  ),
                  const SizedBox(width: 4),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildFilterSection(
                        title: localizations.status,
                        options: [
                          'All',
                          'Planning',
                          'On track',
                          'At risk',
                          'Ended',
                        ].map(
                              (status) {
                            return _localizedStatus(
                              status,
                              localizations,
                            );
                          },
                        ).toList(),
                        selectedValue:
                        _localizedStatus(
                          _selectedStatus,
                          localizations,
                        ),
                        onChanged: (value) {
                          setState(() {
                            if (value == localizations.all) {
                              _selectedStatus = 'All';
                            } else if (value == localizations.planning) {
                              _selectedStatus = 'Planning';
                            } else if (value == localizations.onTrack) {
                              _selectedStatus = 'On track';
                            } else if (value == localizations.atRisk) {
                              _selectedStatus = 'At risk';
                            } else if (value == localizations.ended) {
                              _selectedStatus = 'Ended';
                            }
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      _buildFilterSection(
                        title: localizations.progress,
                        options: [
                          'All',
                          'Not started',
                          'In progress',
                          'Almost complete',
                          'Completed',
                        ].map(
                              (progress) {
                            return _localizedProgress(
                              progress,
                              localizations,
                            );
                          },
                        ).toList(),
                        selectedValue:
                        _localizedProgress(
                          _selectedProgress,
                          localizations,
                        ),
                        onChanged: (value) {
                          setState(() {
                            if (value == localizations.all) {
                              _selectedProgress = 'All';
                            } else if (value == localizations.notStarted) {
                              _selectedProgress = 'Not started';
                            } else if (value == localizations.inProgress) {
                              _selectedProgress = 'In progress';
                            } else if (value == localizations.almostComplete) {
                              _selectedProgress = 'Almost complete';
                            } else if (value == localizations.completed) {
                              _selectedProgress = 'Completed';
                            }
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      _buildFilterSection(
                        title: localizations.location,
                        options: [
                          'All',
                          ...ProjectFilter.locations(widget.projects),
                        ].map(
                              (location) {
                            if (location == 'All') {
                              return localizations.all;
                            }

                            return location;
                          },
                        ).toList(),
                        selectedValue: _selectedLocation == 'All'
                            ? localizations.all
                            : _selectedLocation,
                        onChanged: (value) {
                          setState(() {
                            if (value == localizations.all) {
                              _selectedLocation = 'All';
                            } else {
                              _selectedLocation = value;
                            }
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      _buildFilterSection(
                        title: localizations.dueDate,
                        options: [
                          'All',
                          'Overdue',
                          'This week',
                          'This month',
                        ].map(
                              (date) {
                            return _localizedDate(
                              date,
                              localizations,
                            );
                          },
                        ).toList(),
                        selectedValue:
                        _localizedDate(
                          _selectedDate,
                          localizations,
                        ),
                        onChanged: (value) {
                          setState(() {
                            if (value == localizations.all) {
                              _selectedDate = 'All';
                            } else if (value == localizations.overdue) {
                              _selectedDate = 'Overdue';
                            } else if (value == localizations.thisWeek) {
                              _selectedDate = 'This week';
                            } else if (value == localizations.thisMonth) {
                              _selectedDate = 'This month';
                            }
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
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

class ProjectFilterValues {
  final String status;
  final String progress;
  final String location;
  final String date;

  const ProjectFilterValues({
    required this.status,
    required this.progress,
    required this.location,
    required this.date,
  });
}