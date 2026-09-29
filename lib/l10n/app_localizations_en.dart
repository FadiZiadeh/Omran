// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get welcome => 'Welcome to Omran';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get login => 'Login';

  @override
  String get forgotPassword => 'Forgot Password?';

  @override
  String get logout => 'Logout';

  @override
  String get loginSuccessful => 'Login successful';

  @override
  String get invalidEmailOrPassword => 'Invalid email or password';

  @override
  String get emailRequired => 'Please enter your email';

  @override
  String get invalidEmail => 'Please enter a valid email address';

  @override
  String get passwordRequired => 'Please enter your password';

  @override
  String get passwordTooShort => 'Password must be at least 6 characters';

  @override
  String get welcomeHome => 'Welcome to Omran!';

  @override
  String get language => 'Language';

  @override
  String get lightMode => 'Light Mode';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String get confirmLogout => 'Are you sure you want to logout?';

  @override
  String get cancel => 'Cancel';

  @override
  String get unableToLoadProjects => 'Unable to load projects.';

  @override
  String get unableToLoadTasks => 'Unable to load tasks.';

  @override
  String get activeProjects => 'Active projects';

  @override
  String get viewAll => 'View all';

  @override
  String get noActiveProjects => 'No active projects.';

  @override
  String get jan => 'Jan';

  @override
  String get feb => 'Feb';

  @override
  String get mar => 'Mar';

  @override
  String get apr => 'Apr';

  @override
  String get may => 'May';

  @override
  String get jun => 'Jun';

  @override
  String get jul => 'Jul';

  @override
  String get aug => 'Aug';

  @override
  String get sep => 'Sep';

  @override
  String get oct => 'Oct';

  @override
  String get nov => 'Nov';

  @override
  String get dec => 'Dec';

  @override
  String get goodMorning => 'Good morning';

  @override
  String get user => 'User';

  @override
  String get sitePulseToday => 'Here\'s the site pulse for today.';

  @override
  String get portfolioProgress => 'Portfolio progress';

  @override
  String activeProjectsCount(int count) {
    return '$count active projects';
  }

  @override
  String get liveFromFirebase => 'Live from Firebase';

  @override
  String get complete => 'complete';

  @override
  String get due => 'Due';

  @override
  String get onTrack => 'On track';

  @override
  String get atRisk => 'At risk';

  @override
  String get planning => 'Planning';

  @override
  String get unknownProject => 'Unknown project';

  @override
  String get today => 'Today';

  @override
  String get tomorrow => 'Tomorrow';

  @override
  String get recentActions => 'Recent actions';

  @override
  String get openTaskBoard => 'Open task board';

  @override
  String get noRecentActions => 'No recent actions.';

  @override
  String get todaysFocus => 'Today\'s focus';

  @override
  String openActionsDueToday(int count) {
    return '$count open actions are due today.';
  }

  @override
  String get projects => 'Projects';

  @override
  String get noProjectsFound => 'No projects found.';

  @override
  String get projectsLoadError =>
      'Something went wrong while loading projects.';

  @override
  String get addProject => 'Add Project';

  @override
  String get projectDetails => 'Project Details';

  @override
  String get deleteProject => 'Delete Project';

  @override
  String deleteProjectConfirmation(String projectName) {
    return 'Are you sure you want to delete \"$projectName\"?';
  }

  @override
  String get delete => 'Delete';

  @override
  String failedToDeleteProject(String error) {
    return 'Failed to delete project: $error';
  }

  @override
  String get addSiteUpdate => 'Add Site Update';

  @override
  String get update => 'Update';

  @override
  String get whatHappenedOnSite => 'What happened on site?';

  @override
  String get updateType => 'Update type';

  @override
  String get issue => 'Issue';

  @override
  String get milestone => 'Milestone';

  @override
  String get followUp => 'Follow-up';

  @override
  String get postUpdate => 'Post Update';

  @override
  String get createProject => 'Create Project';

  @override
  String get projectName => 'Project name';

  @override
  String get location => 'Location';

  @override
  String get dueDate => 'Due date';

  @override
  String get selectDueDate => 'Select due date';

  @override
  String get pleaseEnterAllProjectInformation =>
      'Please enter all project information.';

  @override
  String get mustBeLoggedInToCreateProject =>
      'You must be logged in to create a project.';

  @override
  String get projectCreated => 'Project Created';

  @override
  String newProjectCreated(String projectName) {
    return 'New project \"$projectName\" was created.';
  }

  @override
  String failedToCreateProject(String error) {
    return 'Failed to create project: $error';
  }

  @override
  String get editProject => 'Edit Project';

  @override
  String get status => 'Status';

  @override
  String get ended => 'Ended';

  @override
  String get progress => 'Progress';

  @override
  String get saveChanges => 'Save Changes';

  @override
  String failedToUpdateProject(String error) {
    return 'Failed to update project: $error';
  }

  @override
  String get projectEndedReadOnly => 'This project has ended and is read-only.';

  @override
  String get filterProjects => 'Filter Projects';

  @override
  String get clear => 'Clear';

  @override
  String get notStarted => 'Not started';

  @override
  String get inProgress => 'In progress';

  @override
  String get almostComplete => 'Almost complete';

  @override
  String get completed => 'Completed';

  @override
  String get overdue => 'Overdue';

  @override
  String get thisWeek => 'This Week';

  @override
  String get thisMonth => 'This Month';

  @override
  String get applyFilters => 'Apply Filters';

  @override
  String get all => 'All';

  @override
  String get overallProgress => 'Overall progress';

  @override
  String get tasks => 'Tasks';

  @override
  String get files => 'Files';

  @override
  String get searchProjects => 'Search projects...';

  @override
  String get sitePulse => 'Site Pulse';

  @override
  String get unableToLoadProjectUpdates => 'Unable to load project updates.';

  @override
  String get addUpdate => 'Add Update';

  @override
  String get latestProjectActivity =>
      'Latest activity and updates from the project site.';

  @override
  String get noSiteUpdatesYet => 'No site updates yet.';

  @override
  String get open => 'Open';

  @override
  String get noTasksFound => 'No tasks found.';

  @override
  String failedToLoadProjects(String error) {
    return 'Failed to load projects: $error';
  }

  @override
  String failedToLoadTasks(String error) {
    return 'Failed to load tasks: $error';
  }

  @override
  String failedToUpdateTask(String error) {
    return 'Failed to update task: $error';
  }

  @override
  String get mustBeLoggedInToUpdateTask =>
      'You must be logged in to update a task.';

  @override
  String get taskUpdated => 'Task Updated';

  @override
  String taskWasUpdated(String taskTitle) {
    return 'Task \"$taskTitle\" was updated.';
  }

  @override
  String get taskUpdatedSuccessfully => 'Task updated successfully.';

  @override
  String get taskDeleted => 'Task Deleted';

  @override
  String taskWasDeleted(String taskTitle) {
    return 'Task \"$taskTitle\" was deleted.';
  }

  @override
  String get taskDeletedSuccessfully => 'Task deleted successfully.';

  @override
  String failedToDeleteTask(String error) {
    return 'Failed to delete task: $error';
  }

  @override
  String get mustBeLoggedInToCreateTask =>
      'You must be logged in to create a task.';

  @override
  String get taskCreated => 'Task Created';

  @override
  String newTaskCreated(String taskTitle, String projectName) {
    return 'New task \"$taskTitle\" was added to $projectName.';
  }

  @override
  String get taskCreatedSuccessfully => 'Task created successfully.';

  @override
  String failedToCreateTask(String error) {
    return 'Failed to create task: $error';
  }

  @override
  String get todaysTasks => 'Today\'s Tasks';

  @override
  String get tasksDueToday => 'Tasks that are due today.';

  @override
  String get keepTrackOfTasks => 'Keep track of what needs to get done.';

  @override
  String get projectTasks => 'Tasks for this project.';

  @override
  String get tasksCannotBeAddedToEndedProject =>
      'Tasks cannot be added to an ended project.';

  @override
  String get addTask => 'Add Task';

  @override
  String get createTask => 'Create Task';

  @override
  String get pleaseEnterAllTaskInformation =>
      'Please enter all task information.';

  @override
  String get taskTitle => 'Task title';

  @override
  String get project => 'Project';

  @override
  String get priority => 'Priority';

  @override
  String get high => 'High';

  @override
  String get medium => 'Medium';

  @override
  String get low => 'Low';

  @override
  String get deleteTask => 'Delete Task';

  @override
  String deleteTaskConfirmation(String taskTitle) {
    return 'Are you sure you want to delete \"$taskTitle\"?';
  }

  @override
  String get editTask => 'Edit Task';

  @override
  String get pleaseEnterTaskTitle => 'Please enter a task title.';

  @override
  String get assignedTo => 'Assigned To';

  @override
  String get date => 'Date';

  @override
  String get clearAll => 'Clear all';

  @override
  String get filterTasks => 'Filter Tasks';

  @override
  String get searchTasks => 'Search tasks';

  @override
  String get projectTasksReadOnly =>
      'This project has ended. Tasks are read-only.';

  @override
  String get change => 'Change';

  @override
  String get addingTaskAvailableSoon => 'Adding a task will be available soon.';

  @override
  String get unableToLoadProjectTasks => 'Unable to load project tasks.';

  @override
  String get searchFileNameOrLocation => 'Search file name or location';

  @override
  String get allProjectFilesInOnePlace =>
      'All your project files in one place.';

  @override
  String get noFilesFound => 'No files found.';

  @override
  String get unableToLoadFiles => 'Unable to load files.';

  @override
  String get noActiveProjectsForFiles =>
      'No active projects are available for adding files.';

  @override
  String get filesCannotBeAddedToEndedProject =>
      'Files cannot be added to an ended project.';

  @override
  String get addFile => 'Add File';

  @override
  String get projectFiles => 'Project Files';

  @override
  String get allFilesForThisProjectInOnePlace =>
      'All files for this project in one place.';

  @override
  String get projectFilesReadOnly =>
      'This project has ended. Files are read-only.';

  @override
  String get searchProjectFiles => 'Search project files';

  @override
  String get fileUploadedSuccessfully => 'File uploaded successfully.';

  @override
  String get unableToUploadFile => 'Unable to upload file.';

  @override
  String get unableToLoadProjectFiles => 'Unable to load project files.';

  @override
  String get saveFile => 'Save File';

  @override
  String get fileName => 'File Name';

  @override
  String get fileNameHint => 'e.g. Structural Drawings.pdf';

  @override
  String get fileType => 'File Type';

  @override
  String get image => 'Image';

  @override
  String get document => 'Document';

  @override
  String get fileSize => 'File Size';

  @override
  String get fileSizeHint => 'e.g. 4.2 MB';

  @override
  String get pleaseCompleteAllFields => 'Please complete all fields.';

  @override
  String get openFile => 'Open';

  @override
  String get download => 'Download';

  @override
  String get opening => 'Opening';

  @override
  String get downloading => 'Downloading';

  @override
  String get deleting => 'Deleting';

  @override
  String get filters => 'Filters';

  @override
  String get reset => 'Reset';

  @override
  String get close => 'Close';

  @override
  String get profile => 'Profile';

  @override
  String get unableToLoadUserProfile => 'Unable to load user profile.';

  @override
  String get phone => 'Phone';

  @override
  String get about => 'About';

  @override
  String get aboutOmranDescription =>
      'Omran is a project management app designed to help you organize projects, tasks, and files in one place.';

  @override
  String get version => 'Version';

  @override
  String get contact => 'Contact';

  @override
  String get settings => 'Settings';

  @override
  String get notifications => 'Notifications';

  @override
  String get home => 'Home';

  @override
  String get goodAfternoon => 'Good afternoon';

  @override
  String get goodEvening => 'Good evening';
}
