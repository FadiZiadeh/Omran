import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Omran'**
  String get welcome;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPassword;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @loginSuccessful.
  ///
  /// In en, this message translates to:
  /// **'Login successful'**
  String get loginSuccessful;

  /// No description provided for @invalidEmailOrPassword.
  ///
  /// In en, this message translates to:
  /// **'Invalid email or password'**
  String get invalidEmailOrPassword;

  /// No description provided for @emailRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email'**
  String get emailRequired;

  /// No description provided for @invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address'**
  String get invalidEmail;

  /// No description provided for @passwordRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter your password'**
  String get passwordRequired;

  /// No description provided for @passwordTooShort.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get passwordTooShort;

  /// No description provided for @welcomeHome.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Omran!'**
  String get welcomeHome;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @lightMode.
  ///
  /// In en, this message translates to:
  /// **'Light Mode'**
  String get lightMode;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @confirmLogout.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to logout?'**
  String get confirmLogout;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @unableToLoadProjects.
  ///
  /// In en, this message translates to:
  /// **'Unable to load projects.'**
  String get unableToLoadProjects;

  /// No description provided for @unableToLoadTasks.
  ///
  /// In en, this message translates to:
  /// **'Unable to load tasks.'**
  String get unableToLoadTasks;

  /// No description provided for @activeProjects.
  ///
  /// In en, this message translates to:
  /// **'Active projects'**
  String get activeProjects;

  /// No description provided for @viewAll.
  ///
  /// In en, this message translates to:
  /// **'View all'**
  String get viewAll;

  /// No description provided for @noActiveProjects.
  ///
  /// In en, this message translates to:
  /// **'No active projects.'**
  String get noActiveProjects;

  /// No description provided for @jan.
  ///
  /// In en, this message translates to:
  /// **'Jan'**
  String get jan;

  /// No description provided for @feb.
  ///
  /// In en, this message translates to:
  /// **'Feb'**
  String get feb;

  /// No description provided for @mar.
  ///
  /// In en, this message translates to:
  /// **'Mar'**
  String get mar;

  /// No description provided for @apr.
  ///
  /// In en, this message translates to:
  /// **'Apr'**
  String get apr;

  /// No description provided for @may.
  ///
  /// In en, this message translates to:
  /// **'May'**
  String get may;

  /// No description provided for @jun.
  ///
  /// In en, this message translates to:
  /// **'Jun'**
  String get jun;

  /// No description provided for @jul.
  ///
  /// In en, this message translates to:
  /// **'Jul'**
  String get jul;

  /// No description provided for @aug.
  ///
  /// In en, this message translates to:
  /// **'Aug'**
  String get aug;

  /// No description provided for @sep.
  ///
  /// In en, this message translates to:
  /// **'Sep'**
  String get sep;

  /// No description provided for @oct.
  ///
  /// In en, this message translates to:
  /// **'Oct'**
  String get oct;

  /// No description provided for @nov.
  ///
  /// In en, this message translates to:
  /// **'Nov'**
  String get nov;

  /// No description provided for @dec.
  ///
  /// In en, this message translates to:
  /// **'Dec'**
  String get dec;

  /// No description provided for @goodMorning.
  ///
  /// In en, this message translates to:
  /// **'Good morning'**
  String get goodMorning;

  /// No description provided for @user.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get user;

  /// No description provided for @sitePulseToday.
  ///
  /// In en, this message translates to:
  /// **'Here\'s the site pulse for today.'**
  String get sitePulseToday;

  /// No description provided for @portfolioProgress.
  ///
  /// In en, this message translates to:
  /// **'Portfolio progress'**
  String get portfolioProgress;

  /// Number of active projects displayed on the home portfolio card
  ///
  /// In en, this message translates to:
  /// **'{count} active projects'**
  String activeProjectsCount(int count);

  /// No description provided for @liveFromFirebase.
  ///
  /// In en, this message translates to:
  /// **'Live from Firebase'**
  String get liveFromFirebase;

  /// No description provided for @complete.
  ///
  /// In en, this message translates to:
  /// **'complete'**
  String get complete;

  /// No description provided for @due.
  ///
  /// In en, this message translates to:
  /// **'Due'**
  String get due;

  /// No description provided for @onTrack.
  ///
  /// In en, this message translates to:
  /// **'On track'**
  String get onTrack;

  /// No description provided for @atRisk.
  ///
  /// In en, this message translates to:
  /// **'At risk'**
  String get atRisk;

  /// No description provided for @planning.
  ///
  /// In en, this message translates to:
  /// **'Planning'**
  String get planning;

  /// No description provided for @unknownProject.
  ///
  /// In en, this message translates to:
  /// **'Unknown project'**
  String get unknownProject;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @tomorrow.
  ///
  /// In en, this message translates to:
  /// **'Tomorrow'**
  String get tomorrow;

  /// No description provided for @recentActions.
  ///
  /// In en, this message translates to:
  /// **'Recent actions'**
  String get recentActions;

  /// No description provided for @openTaskBoard.
  ///
  /// In en, this message translates to:
  /// **'Open task board'**
  String get openTaskBoard;

  /// No description provided for @noRecentActions.
  ///
  /// In en, this message translates to:
  /// **'No recent actions.'**
  String get noRecentActions;

  /// No description provided for @todaysFocus.
  ///
  /// In en, this message translates to:
  /// **'Today\'s focus'**
  String get todaysFocus;

  /// Number of open tasks due today
  ///
  /// In en, this message translates to:
  /// **'{count} open actions are due today.'**
  String openActionsDueToday(int count);

  /// No description provided for @projects.
  ///
  /// In en, this message translates to:
  /// **'Projects'**
  String get projects;

  /// No description provided for @noProjectsFound.
  ///
  /// In en, this message translates to:
  /// **'No projects found.'**
  String get noProjectsFound;

  /// No description provided for @projectsLoadError.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong while loading projects.'**
  String get projectsLoadError;

  /// No description provided for @addProject.
  ///
  /// In en, this message translates to:
  /// **'Add Project'**
  String get addProject;

  /// No description provided for @projectDetails.
  ///
  /// In en, this message translates to:
  /// **'Project Details'**
  String get projectDetails;

  /// No description provided for @deleteProject.
  ///
  /// In en, this message translates to:
  /// **'Delete Project'**
  String get deleteProject;

  /// Confirmation message before deleting a project
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete \"{projectName}\"?'**
  String deleteProjectConfirmation(String projectName);

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// Error message shown when deleting a project fails
  ///
  /// In en, this message translates to:
  /// **'Failed to delete project: {error}'**
  String failedToDeleteProject(String error);

  /// No description provided for @addSiteUpdate.
  ///
  /// In en, this message translates to:
  /// **'Add Site Update'**
  String get addSiteUpdate;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @whatHappenedOnSite.
  ///
  /// In en, this message translates to:
  /// **'What happened on site?'**
  String get whatHappenedOnSite;

  /// No description provided for @updateType.
  ///
  /// In en, this message translates to:
  /// **'Update type'**
  String get updateType;

  /// No description provided for @issue.
  ///
  /// In en, this message translates to:
  /// **'Issue'**
  String get issue;

  /// No description provided for @milestone.
  ///
  /// In en, this message translates to:
  /// **'Milestone'**
  String get milestone;

  /// No description provided for @followUp.
  ///
  /// In en, this message translates to:
  /// **'Follow-up'**
  String get followUp;

  /// No description provided for @postUpdate.
  ///
  /// In en, this message translates to:
  /// **'Post Update'**
  String get postUpdate;

  /// No description provided for @createProject.
  ///
  /// In en, this message translates to:
  /// **'Create Project'**
  String get createProject;

  /// No description provided for @projectName.
  ///
  /// In en, this message translates to:
  /// **'Project name'**
  String get projectName;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @dueDate.
  ///
  /// In en, this message translates to:
  /// **'Due date'**
  String get dueDate;

  /// No description provided for @selectDueDate.
  ///
  /// In en, this message translates to:
  /// **'Select due date'**
  String get selectDueDate;

  /// No description provided for @pleaseEnterAllProjectInformation.
  ///
  /// In en, this message translates to:
  /// **'Please enter all project information.'**
  String get pleaseEnterAllProjectInformation;

  /// No description provided for @mustBeLoggedInToCreateProject.
  ///
  /// In en, this message translates to:
  /// **'You must be logged in to create a project.'**
  String get mustBeLoggedInToCreateProject;

  /// No description provided for @projectCreated.
  ///
  /// In en, this message translates to:
  /// **'Project Created'**
  String get projectCreated;

  /// Notification body shown when a project is created
  ///
  /// In en, this message translates to:
  /// **'New project \"{projectName}\" was created.'**
  String newProjectCreated(String projectName);

  /// Error message shown when creating a project fails
  ///
  /// In en, this message translates to:
  /// **'Failed to create project: {error}'**
  String failedToCreateProject(String error);

  /// No description provided for @editProject.
  ///
  /// In en, this message translates to:
  /// **'Edit Project'**
  String get editProject;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @ended.
  ///
  /// In en, this message translates to:
  /// **'Ended'**
  String get ended;

  /// No description provided for @progress.
  ///
  /// In en, this message translates to:
  /// **'Progress'**
  String get progress;

  /// No description provided for @saveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get saveChanges;

  /// Error message shown when updating a project fails
  ///
  /// In en, this message translates to:
  /// **'Failed to update project: {error}'**
  String failedToUpdateProject(String error);

  /// No description provided for @projectEndedReadOnly.
  ///
  /// In en, this message translates to:
  /// **'This project has ended and is read-only.'**
  String get projectEndedReadOnly;

  /// No description provided for @filterProjects.
  ///
  /// In en, this message translates to:
  /// **'Filter Projects'**
  String get filterProjects;

  /// No description provided for @clear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clear;

  /// No description provided for @notStarted.
  ///
  /// In en, this message translates to:
  /// **'Not started'**
  String get notStarted;

  /// No description provided for @inProgress.
  ///
  /// In en, this message translates to:
  /// **'In progress'**
  String get inProgress;

  /// No description provided for @almostComplete.
  ///
  /// In en, this message translates to:
  /// **'Almost complete'**
  String get almostComplete;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @overdue.
  ///
  /// In en, this message translates to:
  /// **'Overdue'**
  String get overdue;

  /// No description provided for @thisWeek.
  ///
  /// In en, this message translates to:
  /// **'This Week'**
  String get thisWeek;

  /// No description provided for @thisMonth.
  ///
  /// In en, this message translates to:
  /// **'This Month'**
  String get thisMonth;

  /// No description provided for @applyFilters.
  ///
  /// In en, this message translates to:
  /// **'Apply Filters'**
  String get applyFilters;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @overallProgress.
  ///
  /// In en, this message translates to:
  /// **'Overall progress'**
  String get overallProgress;

  /// No description provided for @tasks.
  ///
  /// In en, this message translates to:
  /// **'Tasks'**
  String get tasks;

  /// No description provided for @files.
  ///
  /// In en, this message translates to:
  /// **'Files'**
  String get files;

  /// No description provided for @searchProjects.
  ///
  /// In en, this message translates to:
  /// **'Search projects...'**
  String get searchProjects;

  /// No description provided for @sitePulse.
  ///
  /// In en, this message translates to:
  /// **'Site Pulse'**
  String get sitePulse;

  /// No description provided for @unableToLoadProjectUpdates.
  ///
  /// In en, this message translates to:
  /// **'Unable to load project updates.'**
  String get unableToLoadProjectUpdates;

  /// No description provided for @addUpdate.
  ///
  /// In en, this message translates to:
  /// **'Add Update'**
  String get addUpdate;

  /// No description provided for @latestProjectActivity.
  ///
  /// In en, this message translates to:
  /// **'Latest activity and updates from the project site.'**
  String get latestProjectActivity;

  /// No description provided for @noSiteUpdatesYet.
  ///
  /// In en, this message translates to:
  /// **'No site updates yet.'**
  String get noSiteUpdatesYet;

  /// No description provided for @open.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get open;

  /// No description provided for @noTasksFound.
  ///
  /// In en, this message translates to:
  /// **'No tasks found.'**
  String get noTasksFound;

  /// Error shown when projects fail to load
  ///
  /// In en, this message translates to:
  /// **'Failed to load projects: {error}'**
  String failedToLoadProjects(String error);

  /// Error shown when tasks fail to load
  ///
  /// In en, this message translates to:
  /// **'Failed to load tasks: {error}'**
  String failedToLoadTasks(String error);

  /// Error shown when updating a task fails
  ///
  /// In en, this message translates to:
  /// **'Failed to update task: {error}'**
  String failedToUpdateTask(String error);

  /// No description provided for @mustBeLoggedInToUpdateTask.
  ///
  /// In en, this message translates to:
  /// **'You must be logged in to update a task.'**
  String get mustBeLoggedInToUpdateTask;

  /// No description provided for @taskUpdated.
  ///
  /// In en, this message translates to:
  /// **'Task Updated'**
  String get taskUpdated;

  /// Notification body shown when a task is updated
  ///
  /// In en, this message translates to:
  /// **'Task \"{taskTitle}\" was updated.'**
  String taskWasUpdated(String taskTitle);

  /// No description provided for @taskUpdatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Task updated successfully.'**
  String get taskUpdatedSuccessfully;

  /// No description provided for @taskDeleted.
  ///
  /// In en, this message translates to:
  /// **'Task Deleted'**
  String get taskDeleted;

  /// Notification body shown when a task is deleted
  ///
  /// In en, this message translates to:
  /// **'Task \"{taskTitle}\" was deleted.'**
  String taskWasDeleted(String taskTitle);

  /// No description provided for @taskDeletedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Task deleted successfully.'**
  String get taskDeletedSuccessfully;

  /// Error shown when deleting a task fails
  ///
  /// In en, this message translates to:
  /// **'Failed to delete task: {error}'**
  String failedToDeleteTask(String error);

  /// No description provided for @mustBeLoggedInToCreateTask.
  ///
  /// In en, this message translates to:
  /// **'You must be logged in to create a task.'**
  String get mustBeLoggedInToCreateTask;

  /// No description provided for @taskCreated.
  ///
  /// In en, this message translates to:
  /// **'Task Created'**
  String get taskCreated;

  /// Notification body shown when a task is created
  ///
  /// In en, this message translates to:
  /// **'New task \"{taskTitle}\" was added to {projectName}.'**
  String newTaskCreated(String taskTitle, String projectName);

  /// No description provided for @taskCreatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Task created successfully.'**
  String get taskCreatedSuccessfully;

  /// Error shown when creating a task fails
  ///
  /// In en, this message translates to:
  /// **'Failed to create task: {error}'**
  String failedToCreateTask(String error);

  /// No description provided for @todaysTasks.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Tasks'**
  String get todaysTasks;

  /// No description provided for @tasksDueToday.
  ///
  /// In en, this message translates to:
  /// **'Tasks that are due today.'**
  String get tasksDueToday;

  /// No description provided for @keepTrackOfTasks.
  ///
  /// In en, this message translates to:
  /// **'Keep track of what needs to get done.'**
  String get keepTrackOfTasks;

  /// No description provided for @projectTasks.
  ///
  /// In en, this message translates to:
  /// **'Tasks for this project.'**
  String get projectTasks;

  /// No description provided for @tasksCannotBeAddedToEndedProject.
  ///
  /// In en, this message translates to:
  /// **'Tasks cannot be added to an ended project.'**
  String get tasksCannotBeAddedToEndedProject;

  /// No description provided for @addTask.
  ///
  /// In en, this message translates to:
  /// **'Add Task'**
  String get addTask;

  /// No description provided for @createTask.
  ///
  /// In en, this message translates to:
  /// **'Create Task'**
  String get createTask;

  /// No description provided for @pleaseEnterAllTaskInformation.
  ///
  /// In en, this message translates to:
  /// **'Please enter all task information.'**
  String get pleaseEnterAllTaskInformation;

  /// No description provided for @taskTitle.
  ///
  /// In en, this message translates to:
  /// **'Task title'**
  String get taskTitle;

  /// No description provided for @project.
  ///
  /// In en, this message translates to:
  /// **'Project'**
  String get project;

  /// No description provided for @priority.
  ///
  /// In en, this message translates to:
  /// **'Priority'**
  String get priority;

  /// No description provided for @high.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get high;

  /// No description provided for @medium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get medium;

  /// No description provided for @low.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get low;

  /// No description provided for @deleteTask.
  ///
  /// In en, this message translates to:
  /// **'Delete Task'**
  String get deleteTask;

  /// Confirmation message shown before deleting a task.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete \"{taskTitle}\"?'**
  String deleteTaskConfirmation(String taskTitle);

  /// No description provided for @editTask.
  ///
  /// In en, this message translates to:
  /// **'Edit Task'**
  String get editTask;

  /// No description provided for @pleaseEnterTaskTitle.
  ///
  /// In en, this message translates to:
  /// **'Please enter a task title.'**
  String get pleaseEnterTaskTitle;

  /// No description provided for @assignedTo.
  ///
  /// In en, this message translates to:
  /// **'Assigned To'**
  String get assignedTo;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @clearAll.
  ///
  /// In en, this message translates to:
  /// **'Clear all'**
  String get clearAll;

  /// No description provided for @filterTasks.
  ///
  /// In en, this message translates to:
  /// **'Filter Tasks'**
  String get filterTasks;

  /// No description provided for @searchTasks.
  ///
  /// In en, this message translates to:
  /// **'Search tasks'**
  String get searchTasks;

  /// No description provided for @projectTasksReadOnly.
  ///
  /// In en, this message translates to:
  /// **'This project has ended. Tasks are read-only.'**
  String get projectTasksReadOnly;

  /// No description provided for @change.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get change;

  /// No description provided for @addingTaskAvailableSoon.
  ///
  /// In en, this message translates to:
  /// **'Adding a task will be available soon.'**
  String get addingTaskAvailableSoon;

  /// No description provided for @unableToLoadProjectTasks.
  ///
  /// In en, this message translates to:
  /// **'Unable to load project tasks.'**
  String get unableToLoadProjectTasks;

  /// No description provided for @searchFileNameOrLocation.
  ///
  /// In en, this message translates to:
  /// **'Search file name or location'**
  String get searchFileNameOrLocation;

  /// No description provided for @allProjectFilesInOnePlace.
  ///
  /// In en, this message translates to:
  /// **'All your project files in one place.'**
  String get allProjectFilesInOnePlace;

  /// No description provided for @noFilesFound.
  ///
  /// In en, this message translates to:
  /// **'No files found.'**
  String get noFilesFound;

  /// No description provided for @unableToLoadFiles.
  ///
  /// In en, this message translates to:
  /// **'Unable to load files.'**
  String get unableToLoadFiles;

  /// No description provided for @noActiveProjectsForFiles.
  ///
  /// In en, this message translates to:
  /// **'No active projects are available for adding files.'**
  String get noActiveProjectsForFiles;

  /// No description provided for @filesCannotBeAddedToEndedProject.
  ///
  /// In en, this message translates to:
  /// **'Files cannot be added to an ended project.'**
  String get filesCannotBeAddedToEndedProject;

  /// No description provided for @addFile.
  ///
  /// In en, this message translates to:
  /// **'Add File'**
  String get addFile;

  /// No description provided for @projectFiles.
  ///
  /// In en, this message translates to:
  /// **'Project Files'**
  String get projectFiles;

  /// No description provided for @allFilesForThisProjectInOnePlace.
  ///
  /// In en, this message translates to:
  /// **'All files for this project in one place.'**
  String get allFilesForThisProjectInOnePlace;

  /// No description provided for @projectFilesReadOnly.
  ///
  /// In en, this message translates to:
  /// **'This project has ended. Files are read-only.'**
  String get projectFilesReadOnly;

  /// No description provided for @searchProjectFiles.
  ///
  /// In en, this message translates to:
  /// **'Search project files'**
  String get searchProjectFiles;

  /// No description provided for @fileUploadedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'File uploaded successfully.'**
  String get fileUploadedSuccessfully;

  /// No description provided for @unableToUploadFile.
  ///
  /// In en, this message translates to:
  /// **'Unable to upload file.'**
  String get unableToUploadFile;

  /// No description provided for @unableToLoadProjectFiles.
  ///
  /// In en, this message translates to:
  /// **'Unable to load project files.'**
  String get unableToLoadProjectFiles;

  /// No description provided for @saveFile.
  ///
  /// In en, this message translates to:
  /// **'Save File'**
  String get saveFile;

  /// No description provided for @fileName.
  ///
  /// In en, this message translates to:
  /// **'File Name'**
  String get fileName;

  /// No description provided for @fileNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Structural Drawings.pdf'**
  String get fileNameHint;

  /// No description provided for @fileType.
  ///
  /// In en, this message translates to:
  /// **'File Type'**
  String get fileType;

  /// No description provided for @image.
  ///
  /// In en, this message translates to:
  /// **'Image'**
  String get image;

  /// No description provided for @document.
  ///
  /// In en, this message translates to:
  /// **'Document'**
  String get document;

  /// No description provided for @fileSize.
  ///
  /// In en, this message translates to:
  /// **'File Size'**
  String get fileSize;

  /// No description provided for @fileSizeHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. 4.2 MB'**
  String get fileSizeHint;

  /// No description provided for @pleaseCompleteAllFields.
  ///
  /// In en, this message translates to:
  /// **'Please complete all fields.'**
  String get pleaseCompleteAllFields;

  /// No description provided for @openFile.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get openFile;

  /// No description provided for @download.
  ///
  /// In en, this message translates to:
  /// **'Download'**
  String get download;

  /// No description provided for @opening.
  ///
  /// In en, this message translates to:
  /// **'Opening'**
  String get opening;

  /// No description provided for @downloading.
  ///
  /// In en, this message translates to:
  /// **'Downloading'**
  String get downloading;

  /// No description provided for @deleting.
  ///
  /// In en, this message translates to:
  /// **'Deleting'**
  String get deleting;

  /// No description provided for @filters.
  ///
  /// In en, this message translates to:
  /// **'Filters'**
  String get filters;

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @unableToLoadUserProfile.
  ///
  /// In en, this message translates to:
  /// **'Unable to load user profile.'**
  String get unableToLoadUserProfile;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @aboutOmranDescription.
  ///
  /// In en, this message translates to:
  /// **'Omran is a project management app designed to help you organize projects, tasks, and files in one place.'**
  String get aboutOmranDescription;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// No description provided for @contact.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get contact;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @goodAfternoon.
  ///
  /// In en, this message translates to:
  /// **'Good afternoon'**
  String get goodAfternoon;

  /// No description provided for @goodEvening.
  ///
  /// In en, this message translates to:
  /// **'Good evening'**
  String get goodEvening;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
