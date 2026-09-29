import 'package:flutter/material.dart';
import 'package:omran/core/localization/locale_controller.dart';
import 'package:omran/core/models/user_profile.dart';
import 'package:omran/core/notifications/view/notifications_view.dart';
import 'package:omran/core/services/user_service.dart';
import 'package:omran/core/theme/theme_controller.dart';
import 'package:omran/features/about/view/about_view.dart';
import 'package:omran/features/authentication/view/login_view.dart';
import 'package:omran/features/files/view/files_view.dart';
import 'package:omran/features/home/view/home_view.dart';
import 'package:omran/features/profile/view/profile_view.dart';
import 'package:omran/features/projects/view/projects_view.dart';
import 'package:omran/features/tasks/view/tasks_view.dart';
import 'package:omran/l10n/app_localizations.dart';
import 'package:omran/core/widgets/liquid_bottom_navigation.dart';

class AppShellView extends StatefulWidget {
  const AppShellView({super.key});

  @override
  State<AppShellView> createState() => _AppShellViewState();
}

class _AppShellViewState extends State<AppShellView> {
  int _currentIndex = 0;
  bool _showTodayOnly = false;

  final GlobalKey<ScaffoldState> _scaffoldKey =
  GlobalKey<ScaffoldState>();

  final UserService _userService = UserService();

  UserProfile? _user;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    try {
      final user = await _userService.getCurrentUser();

      if (!mounted) {
        return;
      }

      setState(() {
        _user = user;
      });
    } catch (e) {
      if (!mounted) {
        return;
      }

      setState(() {
        _user = null;
      });

      // ignore: avoid_print
      print('Unable to load current user: $e');
    }
  }

  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  void _openHome() {
    setState(() {
      _currentIndex = 0;
      _showTodayOnly = false;
    });

    if (_scaffoldKey.currentState?.isDrawerOpen ?? false) {
      Navigator.pop(context);
    }
  }

  void _openProjects() {
    setState(() {
      _currentIndex = 1;
      _showTodayOnly = false;
    });

    if (_scaffoldKey.currentState?.isDrawerOpen ?? false) {
      Navigator.pop(context);
    }
  }

  void _openTasks() {
    setState(() {
      _currentIndex = 2;
      _showTodayOnly = false;
    });

    if (_scaffoldKey.currentState?.isDrawerOpen ?? false) {
      Navigator.pop(context);
    }
  }

  void _openTodayTasks() {
    setState(() {
      _currentIndex = 2;
      _showTodayOnly = true;
    });
  }

  void _openProfile() {
    Navigator.pop(context);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ProfileView(),
      ),
    );
  }

  void _openNotifications() {
    Navigator.pop(context);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const NotificationsView(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: localeController,
      builder: (context, child) {
        final localizations = AppLocalizations.of(context)!;

        final pages = [
          HomeView(
            user: _user,
            onTasksPressed: _openTodayTasks,
            onProjectsPressed: _openProjects,
            onTaskBoardPressed: _openTasks,
          ),
          ProjectsView(
            onMenu: _openDrawer,
          ),
          TasksView(
            showTodayOnly: _showTodayOnly,
            onMenu: _openDrawer,
          ),
          FilesView(
            onMenu: _openDrawer,
          ),
        ];

        return Scaffold(
          key: _scaffoldKey,
          drawer: _buildDrawer(context),
          body: pages[_currentIndex],
          bottomNavigationBar: LiquidBottomNavigation(
            selectedIndex: _currentIndex,
            onDestinationSelected: (index) {
              setState(() {
                _currentIndex = index;

                if (index == 2) {
                  _showTodayOnly = false;
                }
              });
            },
            items: [
              LiquidNavigationItem(
                icon: Icons.home_outlined,
                selectedIcon: Icons.home,
                label: localizations.home,
              ),
              LiquidNavigationItem(
                icon: Icons.business_outlined,
                selectedIcon: Icons.business,
                label: localizations.projects,
              ),
              LiquidNavigationItem(
                icon: Icons.task_outlined,
                selectedIcon: Icons.task,
                label: localizations.tasks,
              ),
              LiquidNavigationItem(
                icon: Icons.folder_outlined,
                selectedIcon: Icons.folder,
                label: localizations.files,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDrawer(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            _buildUserHeader(context),

            const Divider(),

            ListTile(
              leading: const Icon(Icons.person_outline),
              title: Text(localizations.profile),
              onTap: _openProfile,
            ),

            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: Text(localizations.home),
              onTap: _openHome,
            ),

            const SizedBox(height: 16),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  localizations.settings.toUpperCase(),
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium
                      ?.copyWith(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 8),

            _buildSettingsSection(context),

            ListTile(
              leading: const Icon(Icons.info_outline),
              title: Text(localizations.about),
              onTap: () {
                Navigator.pop(context);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AboutView(),
                  ),
                );
              },
            ),

            const Spacer(),

            ListTile(
              leading: const Icon(
                Icons.logout,
                color: Colors.red,
              ),
              title: Text(
                localizations.logout,
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onTap: _showLogoutConfirmation,
            ),

            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  Widget _buildUserHeader(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 12, 16),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            child: Text(
              _user?.initials ?? '?',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _user?.fullName ?? localizations.user,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  _user?.role ?? '',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall,
                ),
              ],
            ),
          ),

          IconButton(
            tooltip: localizations.notifications,
            onPressed: _openNotifications,
            icon: const Icon(
              Icons.notifications_outlined,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsSection(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return ExpansionTile(
      leading: const Icon(Icons.settings_outlined),
      title: Text(localizations.settings),
      children: [
        ListTile(
          leading: const Icon(Icons.language),
          title: Text(localizations.language),
          trailing: DropdownButton<String>(
            value: localeController.locale.languageCode,
            underline: const SizedBox(),
            items: const [
              DropdownMenuItem(
                value: 'en',
                child: Text('English'),
              ),
              DropdownMenuItem(
                value: 'ar',
                child: Text('العربية'),
              ),
            ],
            onChanged: (value) {
              if (value == null) {
                return;
              }

              localeController.setLocale(
                Locale(value),
              );
            },
          ),
        ),

        ListTile(
          leading: const Icon(Icons.dark_mode_outlined),
          title: Text(localizations.darkMode),
          trailing: Switch(
            value: themeController.isDarkMode,
            onChanged: (value) {
              themeController.toggleTheme(value);
            },
          ),
        ),
      ],
    );
  }

  void _showLogoutConfirmation() {
    final localizations = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(localizations.logout),
          content: Text(localizations.confirmLogout),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(localizations.cancel),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(context);

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginView(),
                  ),
                      (route) => false,
                );
              },
              child: Text(localizations.logout),
            ),
          ],
        );
      },
    );
  }
}