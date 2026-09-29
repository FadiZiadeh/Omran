import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:omran/core/models/file_item.dart';
import 'package:omran/core/services/firebase_storage_service.dart';
import 'package:omran/core/widgets/curved_header.dart';
import 'package:omran/features/files/service/file_service.dart';
import 'package:omran/features/files/widgets/file_project_section.dart';
import 'package:omran/l10n/app_localizations.dart';

class ProjectFilesView extends StatefulWidget {
  final String projectId;
  final String projectName;
  final bool isEnded;

  const ProjectFilesView({
    super.key,
    required this.projectId,
    required this.projectName,
    this.isEnded = false,
  });

  @override
  State<ProjectFilesView> createState() =>
      _ProjectFilesViewState();
}

class _ProjectFilesViewState extends State<ProjectFilesView> {
  final FileService _fileService = FileService();

  final FirebaseStorageService _storageService =
  FirebaseStorageService();

  final TextEditingController _searchController =
  TextEditingController();

  String _searchQuery = '';

  List<FileItem> _filterFiles(List<FileItem> files) {
    if (_searchQuery.isEmpty) {
      return files;
    }

    final query = _searchQuery.toLowerCase();

    return files.where((file) {
      return file.name.toLowerCase().contains(query);
    }).toList();
  }

  Future<void> _uploadFile() async {
    if (widget.isEnded) {
      return;
    }

    final localizations = AppLocalizations.of(context)!;

    try {
      final result = await FilePicker.platform.pickFiles();

      if (result == null) {
        return;
      }

      final pickedFile = result.files.single;

      if (pickedFile.path == null) {
        return;
      }

      final file = File(pickedFile.path!);

      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        return;
      }

      final fileName = pickedFile.name;

      final fileUrl = await _storageService.uploadFile(
        file: file,
        projectId: widget.projectId,
        fileName: fileName,
      );

      final fileItem = FileItem(
        id: '',
        name: fileName,
        projectId: widget.projectId,
        type: pickedFile.extension ?? 'file',
        size: '${(pickedFile.size / 1024).toStringAsFixed(1)} KB',
        createdAt: DateTime.now(),
        storageUrl: fileUrl,
        uploadedBy: user.uid,
      );

      await _fileService.addFile(fileItem);

      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            localizations.fileUploadedSuccessfully,
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
            localizations.unableToUploadFile,
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

    return StreamBuilder<List<FileItem>>(
      stream: _fileService.getFilesByProject(
        widget.projectId,
      ),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            body: Column(
              children: [
                CurvedHeader(
                  title:
                  '${widget.projectName} ${localizations.files}',
                  onBack: () {
                    Navigator.pop(context);
                  },
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      localizations.unableToLoadProjectFiles,
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
                  '${widget.projectName} ${localizations.files}',
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

        final allFiles = snapshot.data ?? [];
        final files = _filterFiles(allFiles);

        return Scaffold(
          body: Column(
            children: [
              CurvedHeader(
                title:
                '${widget.projectName} ${localizations.files}',
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
                        localizations.projectFiles,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        localizations
                            .allFilesForThisProjectInOnePlace,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium,
                      ),
                      if (widget.isEnded) ...[
                        const SizedBox(height: 16),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(14),
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
                                      .projectFilesReadOnly,
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
                            _searchQuery = value.trim();
                          });
                        },
                        decoration: InputDecoration(
                          hintText:
                          localizations.searchProjectFiles,
                          prefixIcon:
                          const Icon(Icons.search),
                          suffixIcon:
                          _searchQuery.isNotEmpty
                              ? IconButton(
                            onPressed: () {
                              _searchController
                                  .clear();

                              setState(() {
                                _searchQuery = '';
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
                      const SizedBox(height: 28),
                      if (files.isEmpty)
                        Center(
                          child: Padding(
                            padding:
                            const EdgeInsets.all(32),
                            child: Text(
                              localizations.noFilesFound,
                            ),
                          ),
                        )
                      else
                        FileProjectSection(
                          projectName: widget.projectName,
                          files: files,
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
            onPressed: _uploadFile,
            icon: const Icon(
              Icons.upload_file,
            ),
            label: Text(
              localizations.addFile,
            ),
          ),
        );
      },
    );
  }
}