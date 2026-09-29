import 'package:flutter/material.dart';
import 'package:omran/core/models/project.dart';
import 'package:omran/core/services/project_service.dart';
import 'package:omran/core/widgets/curved_header.dart';
import 'package:omran/core/widgets/skeleton/skeleton_box.dart';
import 'package:omran/features/projects/widgets/project_list_card.dart';
import 'package:omran/features/projects/utils/project_filter.dart';
import 'package:omran/features/projects/widgets/project_filter_sheet.dart';
import 'package:omran/features/projects/widgets/create_project_sheet.dart';
import 'package:omran/core/notifications/notification_service.dart';
import 'package:omran/features/projects/widgets/project_search_bar.dart';
import 'package:omran/features/projects/widgets/project_filter_chips.dart';
import 'package:omran/l10n/app_localizations.dart';

class ProjectsView extends StatefulWidget {
  final VoidCallback? onMenu;

  const ProjectsView({
    super.key,
    this.onMenu,
  });

  @override
  State<ProjectsView> createState() => _ProjectsViewState();
}

class _ProjectsViewState extends State<ProjectsView> {
  final ProjectService _projectService = ProjectService();

  final TextEditingController _searchController =
  TextEditingController();

  String _searchQuery = '';

  String _statusFilter = 'All';
  String _progressFilter = 'All';
  String _locationFilter = 'All';
  String _dateFilter = 'All';

  void _clearFilters() {
    setState(() {
      _statusFilter = 'All';
      _progressFilter = 'All';
      _locationFilter = 'All';
      _dateFilter = 'All';
    });
  }

  void _showFilterSheet(List<Project> projects) async {
    final result =
    await showModalBottomSheet<ProjectFilterValues>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) {
        return ProjectFilterSheet(
          projects: projects,
          selectedStatus: _statusFilter,
          selectedProgress: _progressFilter,
          selectedLocation: _locationFilter,
          selectedDate: _dateFilter,
        );
      },
    );

    if (result == null) {
      return;
    }

    setState(() {
      _statusFilter = result.status;
      _progressFilter = result.progress;
      _locationFilter = result.location;
      _dateFilter = result.date;
    });
  }

  void _showCreateProjectSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      isDismissible: false,
      enableDrag: false,
      builder: (context) {
        return CreateProjectSheet(
          projectService: _projectService,
          notificationService: NotificationService(),
        );
      },
    );
  }

  Widget _buildSkeleton() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          SkeletonBox(
            width: double.infinity,
            height: 56,
            borderRadius: BorderRadius.circular(14),
          ),
          const SizedBox(height: 24),
          SkeletonBox(
            width: double.infinity,
            height: 180,
            borderRadius: BorderRadius.circular(14),
          ),
          const SizedBox(height: 12),
          SkeletonBox(
            width: double.infinity,
            height: 180,
            borderRadius: BorderRadius.circular(14),
          ),
          const SizedBox(height: 12),
          SkeletonBox(
            width: double.infinity,
            height: 180,
            borderRadius: BorderRadius.circular(14),
          ),
        ],
      ),
    );
  }

  Widget _buildProjects(List<Project> projects) {
    final filtered = ProjectFilter.apply(
      projects: projects,
      searchQuery: _searchQuery,
      status: _statusFilter,
      progress: _progressFilter,
      location: _locationFilter,
      date: _dateFilter,
    );

    final activeFilterCount =
    ProjectFilter.activeFilterCount(
      status: _statusFilter,
      progress: _progressFilter,
      location: _locationFilter,
      date: _dateFilter,
    );

    final localizations = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(
        20,
        16,
        20,
        100,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),

          Row(
            children: [
              Expanded(
                child: ProjectSearchBar(
                  controller: _searchController,
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                ),
              ),

              const SizedBox(width: 10),

              Stack(
                children: [
                  IconButton(
                    onPressed: () {
                      _showFilterSheet(projects);
                    },
                    style: IconButton.styleFrom(
                      backgroundColor:
                      Theme.of(context)
                          .colorScheme
                          .primary,
                      foregroundColor:
                      Theme.of(context)
                          .colorScheme
                          .onPrimary,
                    ),
                    icon: const Icon(Icons.tune),
                  ),

                  if (activeFilterCount > 0)
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration:
                        const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '$activeFilterCount',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),

          if (activeFilterCount > 0) ...[
            const SizedBox(height: 12),
            ProjectFilterChips(
              status: _statusFilter,
              progress: _progressFilter,
              location: _locationFilter,
              date: _dateFilter,
              onClearStatus: () {
                setState(() {
                  _statusFilter = 'All';
                });
              },
              onClearProgress: () {
                setState(() {
                  _progressFilter = 'All';
                });
              },
              onClearLocation: () {
                setState(() {
                  _locationFilter = 'All';
                });
              },
              onClearDate: () {
                setState(() {
                  _dateFilter = 'All';
                });
              },
              onClearAll: _clearFilters,
            ),
          ],

          const SizedBox(height: 24),

          if (filtered.isEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Text(
                  localizations.noProjectsFound,
                ),
              ),
            )
          else
            ...filtered.map(
                  (project) => Padding(
                padding: const EdgeInsets.only(
                  bottom: 12,
                ),
                child: ProjectListCard(
                  project: project,
                ),
              ),
            ),
        ],
      ),
    );
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
            title: localizations.projects,
            onMenu: widget.onMenu,
          ),
          Expanded(
            child: StreamBuilder<List<Project>>(
              stream: _projectService.getProjects(),
              builder: (context, snapshot) {
                if (snapshot.connectionState ==
                    ConnectionState.waiting &&
                    !snapshot.hasData) {
                  return _buildSkeleton();
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisSize:
                        MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.error_outline,
                            size: 48,
                            color: Colors.red,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            localizations
                                .projectsLoadError,
                            textAlign:
                            TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '${snapshot.error}',
                            textAlign:
                            TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall,
                          ),
                        ],
                      ),
                    ),
                  );
                }

                final projects =
                    snapshot.data ?? [];

                return _buildProjects(projects);
              },
            ),
          ),
        ],
      ),
      floatingActionButton:
      FloatingActionButton.extended(
        onPressed: _showCreateProjectSheet,
        icon: const Icon(Icons.add_business),
        label: Text(
          localizations.addProject,
        ),
      ),
    );
  }
}