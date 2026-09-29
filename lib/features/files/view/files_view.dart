import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:omran/core/models/file_item.dart';
import 'package:omran/core/models/project.dart';
import 'package:omran/core/services/project_service.dart';
import 'package:omran/core/widgets/curved_header.dart';
import 'package:omran/features/files/service/file_service.dart';
import 'package:omran/features/files/utils/file_filter_helper.dart';
import 'package:omran/features/files/widgets/add_file_sheet.dart';
import 'package:omran/features/files/widgets/file_filter_sheet.dart';
import 'package:omran/features/files/widgets/file_project_section.dart';
import 'package:omran/l10n/app_localizations.dart';

class FilesView extends StatefulWidget {
  final String? projectName;
  final VoidCallback? onMenu;

  const FilesView({
    super.key,
    this.projectName,
    this.onMenu,
  });

  @override
  State<FilesView> createState() => _FilesViewState();
}

class _FilesViewState extends State<FilesView> {
  final TextEditingController _searchController =
  TextEditingController();

  final FileService _fileService = FileService();
  final ProjectService _projectService = ProjectService();

  String _searchQuery = '';
  String _typeFilter = 'All';
  String _projectFilter = 'All';
  String _dateFilter = 'All';

  int get _activeFilterCount {
    int count = 0;

    if (_typeFilter != 'All') {
      count++;
    }

    if (_projectFilter != 'All') {
      count++;
    }

    if (_dateFilter != 'All') {
      count++;
    }

    return count;
  }

  void _clearFilters() {
    setState(() {
      _typeFilter = 'All';
      _projectFilter = 'All';
      _dateFilter = 'All';
    });
  }

  void _showFilterSheet(List<Project> projects) async {
    final result = await showModalBottomSheet<FileFilterResult>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) {
        return FileFilterSheet(
          projects: projects,
          selectedType: _typeFilter,
          selectedProject: _projectFilter,
          selectedDate: _dateFilter,
        );
      },
    );

    if (result == null || !mounted) {
      return;
    }

    setState(() {
      _typeFilter = result.type;
      _projectFilter = result.project;
      _dateFilter = result.date;
    });
  }

  Widget _buildActiveFilterChip(
      String label,
      VoidCallback onDeleted,
      ) {
    return Chip(
      label: Text(label),
      deleteIcon: const Icon(
        Icons.close,
        size: 18,
      ),
      onDeleted: onDeleted,
    );
  }

  void _showAddFileSheet(List<Project> projects) {
    final localizations = AppLocalizations.of(context)!;

    final availableProjects = projects
        .where((project) => project.status != 'Ended')
        .toList();

    if (availableProjects.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            localizations.noActiveProjectsForFiles,
          ),
        ),
      );
      return;
    }

    String? selectedProjectId;

    if (widget.projectName != null) {
      final project = FileFilterHelper.projectFromName(
        widget.projectName!,
        availableProjects,
      );

      selectedProjectId = project?.id;
    }

    selectedProjectId ??= availableProjects.first.id;

    showModalBottomSheet<AddFileResult>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) {
        return AddFileSheet(
          projects: availableProjects,
          selectedProjectId: selectedProjectId,
        );
      },
    ).then((result) async {
      if (result == null) {
        return;
      }

      final currentUser =
          FirebaseAuth.instance.currentUser;

      if (currentUser == null) {
        return;
      }

      final file = FileItem(
        id: '',
        name: result.name,
        projectId: result.projectId,
        type: result.type,
        size: result.size,
        createdAt: DateTime.now(),
        storageUrl: '',
        uploadedBy: currentUser.uid,
      );

      await _fileService.addFile(file);
    });
  }

  Widget _buildStateScaffold({
    required Widget child,
  }) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      body: Column(
        children: [
          CurvedHeader(
            title: localizations.files,
            onMenu: widget.onMenu,
          ),
          Expanded(
            child: Center(
              child: child,
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

  Widget _buildSearchAndFilters(
      BuildContext context,
      List<Project> projects,
      ) {
    final localizations = AppLocalizations.of(context)!;

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _searchController,
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
                decoration: InputDecoration(
                  hintText:
                  localizations.searchFileNameOrLocation,
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                    onPressed: () {
                      _searchController.clear();

                      setState(() {
                        _searchQuery = '';
                      });
                    },
                    icon: const Icon(Icons.clear),
                  )
                      : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Stack(
              children: [
                OutlinedButton.icon(
                  onPressed: () {
                    _showFilterSheet(projects);
                  },
                  icon: const Icon(
                    Icons.filter_list,
                    size: 20,
                  ),
                  label: const SizedBox.shrink(),
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(44, 56),
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
                if (_activeFilterCount > 0)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '$_activeFilterCount',
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
        if (_activeFilterCount > 0) ...[
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              if (_typeFilter != 'All')
                _buildActiveFilterChip(
                  _typeFilter,
                      () {
                    setState(() {
                      _typeFilter = 'All';
                    });
                  },
                ),
              if (_projectFilter != 'All')
                _buildActiveFilterChip(
                  _projectFilter,
                      () {
                    setState(() {
                      _projectFilter = 'All';
                    });
                  },
                ),
              if (_dateFilter != 'All')
                _buildActiveFilterChip(
                  _dateFilter,
                      () {
                    setState(() {
                      _dateFilter = 'All';
                    });
                  },
                ),
              ActionChip(
                label: Text(localizations.clearAll),
                onPressed: _clearFilters,
              ),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildFilesContent({
    required BuildContext context,
    required List<Project> projects,
    required List<FileItem> filteredFiles,
    required Map<String, List<FileItem>> groupedFiles,
  }) {
    final localizations = AppLocalizations.of(context)!;

    final projectNames =
    projects.map((project) => project.name).toList();

    return Scaffold(
      body: Column(
        children: [
          CurvedHeader(
            title: localizations.files,
            onMenu: widget.onMenu,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.projectName == null
                        ? localizations.files
                        : '${widget.projectName} ${localizations.files}',
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    localizations.allProjectFilesInOnePlace,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium,
                  ),
                  const SizedBox(height: 24),
                  _buildSearchAndFilters(
                    context,
                    projects,
                  ),
                  const SizedBox(height: 28),
                  if (filteredFiles.isEmpty)
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(32),
                        child: Text(
                          localizations.noFilesFound,
                        ),
                      ),
                    ),
                  for (final projectName in projectNames)
                    if (groupedFiles[projectName]!.isNotEmpty) ...[
                      FileProjectSection(
                        projectName: projectName,
                        files: groupedFiles[projectName]!,
                      ),
                      const SizedBox(height: 24),
                    ],
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final allProjects =
          await _projectService.getProjects().first;

          if (!context.mounted) {
            return;
          }

          if (widget.projectName != null) {
            final project = FileFilterHelper.projectFromName(
              widget.projectName!,
              allProjects,
            );

            if (project?.status == 'Ended') {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    localizations
                        .filesCannotBeAddedToEndedProject,
                  ),
                ),
              );
              return;
            }
          }

          _showAddFileSheet(allProjects);
        },
        icon: const Icon(Icons.upload_file),
        label: Text(localizations.addFile),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return StreamBuilder<List<Project>>(
      stream: _projectService.getProjects(),
      builder: (context, projectSnapshot) {
        if (projectSnapshot.hasError) {
          return _buildStateScaffold(
            child: Text(
              localizations.unableToLoadProjects,
            ),
          );
        }

        if (projectSnapshot.connectionState ==
            ConnectionState.waiting) {
          return _buildStateScaffold(
            child: const CircularProgressIndicator(),
          );
        }

        final projects = projectSnapshot.data ?? [];

        return StreamBuilder<List<FileItem>>(
          stream: _fileService.getFiles(),
          builder: (context, fileSnapshot) {
            if (fileSnapshot.hasError) {
              return _buildStateScaffold(
                child: Text(
                  localizations.unableToLoadFiles,
                ),
              );
            }

            if (fileSnapshot.connectionState ==
                ConnectionState.waiting) {
              return _buildStateScaffold(
                child: const CircularProgressIndicator(),
              );
            }

            final files = fileSnapshot.data ?? [];

            final filteredFiles =
            FileFilterHelper.filterFiles(
              files: files,
              projects: projects,
              searchQuery: _searchQuery,
              typeFilter: _typeFilter,
              projectFilter: _projectFilter,
              dateFilter: _dateFilter,
              projectName: widget.projectName,
            );

            final groupedFiles =
            FileFilterHelper.groupFilesByProject(
              files: filteredFiles,
              projects: projects,
            );

            return _buildFilesContent(
              context: context,
              projects: projects,
              filteredFiles: filteredFiles,
              groupedFiles: groupedFiles,
            );
          },
        );
      },
    );
  }
}