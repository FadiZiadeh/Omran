// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get welcome => 'مرحباً بك في عمران';

  @override
  String get email => 'البريد الإلكتروني';

  @override
  String get password => 'كلمة المرور';

  @override
  String get login => 'تسجيل الدخول';

  @override
  String get forgotPassword => 'هل نسيت كلمة المرور؟';

  @override
  String get logout => 'تسجيل الخروج';

  @override
  String get loginSuccessful => 'تم تسجيل الدخول بنجاح';

  @override
  String get invalidEmailOrPassword =>
      'البريد الإلكتروني أو كلمة المرور غير صحيحة';

  @override
  String get emailRequired => 'يرجى إدخال البريد الإلكتروني';

  @override
  String get invalidEmail => 'يرجى إدخال بريد إلكتروني صحيح';

  @override
  String get passwordRequired => 'يرجى إدخال كلمة المرور';

  @override
  String get passwordTooShort => 'يجب أن تتكون كلمة المرور من 6 أحرف على الأقل';

  @override
  String get welcomeHome => 'مرحباً بك في عمران!';

  @override
  String get language => 'اللغة';

  @override
  String get lightMode => 'الوضع الفاتح';

  @override
  String get darkMode => 'الوضع الداكن';

  @override
  String get confirmLogout => 'هل أنت متأكد أنك تريد تسجيل الخروج؟';

  @override
  String get cancel => 'إلغاء';

  @override
  String get unableToLoadProjects => 'تعذر تحميل المشاريع.';

  @override
  String get unableToLoadTasks => 'تعذر تحميل المهام.';

  @override
  String get activeProjects => 'المشاريع النشطة';

  @override
  String get viewAll => 'عرض الكل';

  @override
  String get noActiveProjects => 'لا توجد مشاريع نشطة.';

  @override
  String get jan => 'يناير';

  @override
  String get feb => 'فبراير';

  @override
  String get mar => 'مارس';

  @override
  String get apr => 'أبريل';

  @override
  String get may => 'مايو';

  @override
  String get jun => 'يونيو';

  @override
  String get jul => 'يوليو';

  @override
  String get aug => 'أغسطس';

  @override
  String get sep => 'سبتمبر';

  @override
  String get oct => 'أكتوبر';

  @override
  String get nov => 'نوفمبر';

  @override
  String get dec => 'ديسمبر';

  @override
  String get goodMorning => 'صباح الخير';

  @override
  String get user => 'المستخدم';

  @override
  String get sitePulseToday => 'إليك نبض الموقع لهذا اليوم.';

  @override
  String get portfolioProgress => 'تقدم المشاريع';

  @override
  String activeProjectsCount(int count) {
    return '$count مشاريع نشطة';
  }

  @override
  String get liveFromFirebase => 'مباشر من Firebase';

  @override
  String get complete => 'مكتمل';

  @override
  String get due => 'مستحق';

  @override
  String get onTrack => 'في المسار الصحيح';

  @override
  String get atRisk => 'في خطر';

  @override
  String get planning => 'قيد التخطيط';

  @override
  String get unknownProject => 'مشروع غير معروف';

  @override
  String get today => 'اليوم';

  @override
  String get tomorrow => 'غدًا';

  @override
  String get recentActions => 'الإجراءات الأخيرة';

  @override
  String get openTaskBoard => 'فتح لوحة المهام';

  @override
  String get noRecentActions => 'لا توجد إجراءات حديثة.';

  @override
  String get todaysFocus => 'تركيز اليوم';

  @override
  String openActionsDueToday(int count) {
    return 'هناك $count مهام مفتوحة مستحقة اليوم.';
  }

  @override
  String get projects => 'المشاريع';

  @override
  String get noProjectsFound => 'لم يتم العثور على مشاريع.';

  @override
  String get projectsLoadError => 'حدث خطأ أثناء تحميل المشاريع.';

  @override
  String get addProject => 'إضافة مشروع';

  @override
  String get projectDetails => 'تفاصيل المشروع';

  @override
  String get deleteProject => 'حذف المشروع';

  @override
  String deleteProjectConfirmation(String projectName) {
    return 'هل أنت متأكد أنك تريد حذف \"$projectName\"؟';
  }

  @override
  String get delete => 'حذف';

  @override
  String failedToDeleteProject(String error) {
    return 'فشل حذف المشروع: $error';
  }

  @override
  String get addSiteUpdate => 'إضافة تحديث للموقع';

  @override
  String get update => 'تحديث';

  @override
  String get whatHappenedOnSite => 'ماذا حدث في الموقع؟';

  @override
  String get updateType => 'نوع التحديث';

  @override
  String get issue => 'مشكلة';

  @override
  String get milestone => 'مرحلة رئيسية';

  @override
  String get followUp => 'متابعة';

  @override
  String get postUpdate => 'نشر التحديث';

  @override
  String get createProject => 'إنشاء مشروع';

  @override
  String get projectName => 'اسم المشروع';

  @override
  String get location => 'الموقع';

  @override
  String get dueDate => 'تاريخ الاستحقاق';

  @override
  String get selectDueDate => 'اختر تاريخ الاستحقاق';

  @override
  String get pleaseEnterAllProjectInformation =>
      'يرجى إدخال جميع معلومات المشروع.';

  @override
  String get mustBeLoggedInToCreateProject => 'يجب تسجيل الدخول لإنشاء مشروع.';

  @override
  String get projectCreated => 'تم إنشاء المشروع';

  @override
  String newProjectCreated(String projectName) {
    return 'تم إنشاء مشروع جديد باسم \"$projectName\".';
  }

  @override
  String failedToCreateProject(String error) {
    return 'فشل إنشاء المشروع: $error';
  }

  @override
  String get editProject => 'تعديل المشروع';

  @override
  String get status => 'الحالة';

  @override
  String get ended => 'منتهٍ';

  @override
  String get progress => 'التقدم';

  @override
  String get saveChanges => 'حفظ التغييرات';

  @override
  String failedToUpdateProject(String error) {
    return 'فشل تحديث المشروع: $error';
  }

  @override
  String get projectEndedReadOnly => 'انتهى هذا المشروع وأصبح للقراءة فقط.';

  @override
  String get filterProjects => 'تصفية المشاريع';

  @override
  String get clear => 'مسح';

  @override
  String get notStarted => 'لم يبدأ';

  @override
  String get inProgress => 'قيد التنفيذ';

  @override
  String get almostComplete => 'شبه مكتمل';

  @override
  String get completed => 'مكتملة';

  @override
  String get overdue => 'متأخر';

  @override
  String get thisWeek => 'هذا الأسبوع';

  @override
  String get thisMonth => 'هذا الشهر';

  @override
  String get applyFilters => 'تطبيق التصفية';

  @override
  String get all => 'الكل';

  @override
  String get overallProgress => 'التقدم الإجمالي';

  @override
  String get tasks => 'المهام';

  @override
  String get files => 'الملفات';

  @override
  String get searchProjects => 'البحث عن المشاريع...';

  @override
  String get sitePulse => 'نبض الموقع';

  @override
  String get unableToLoadProjectUpdates => 'تعذر تحميل تحديثات المشروع.';

  @override
  String get addUpdate => 'إضافة تحديث';

  @override
  String get latestProjectActivity =>
      'أحدث الأنشطة والتحديثات من موقع المشروع.';

  @override
  String get noSiteUpdatesYet => 'لا توجد تحديثات للموقع بعد.';

  @override
  String get open => 'مفتوحة';

  @override
  String get noTasksFound => 'لم يتم العثور على مهام.';

  @override
  String failedToLoadProjects(String error) {
    return 'فشل تحميل المشاريع: $error';
  }

  @override
  String failedToLoadTasks(String error) {
    return 'فشل تحميل المهام: $error';
  }

  @override
  String failedToUpdateTask(String error) {
    return 'فشل تحديث المهمة: $error';
  }

  @override
  String get mustBeLoggedInToUpdateTask => 'يجب تسجيل الدخول لتحديث مهمة.';

  @override
  String get taskUpdated => 'تم تحديث المهمة';

  @override
  String taskWasUpdated(String taskTitle) {
    return 'تم تحديث المهمة \"$taskTitle\".';
  }

  @override
  String get taskUpdatedSuccessfully => 'تم تحديث المهمة بنجاح.';

  @override
  String get taskDeleted => 'تم حذف المهمة';

  @override
  String taskWasDeleted(String taskTitle) {
    return 'تم حذف المهمة \"$taskTitle\".';
  }

  @override
  String get taskDeletedSuccessfully => 'تم حذف المهمة بنجاح.';

  @override
  String failedToDeleteTask(String error) {
    return 'فشل حذف المهمة: $error';
  }

  @override
  String get mustBeLoggedInToCreateTask => 'يجب تسجيل الدخول لإنشاء مهمة.';

  @override
  String get taskCreated => 'تم إنشاء المهمة';

  @override
  String newTaskCreated(String taskTitle, String projectName) {
    return 'تمت إضافة المهمة \"$taskTitle\" إلى $projectName.';
  }

  @override
  String get taskCreatedSuccessfully => 'تم إنشاء المهمة بنجاح.';

  @override
  String failedToCreateTask(String error) {
    return 'فشل إنشاء المهمة: $error';
  }

  @override
  String get todaysTasks => 'مهام اليوم';

  @override
  String get tasksDueToday => 'المهام المستحقة اليوم.';

  @override
  String get keepTrackOfTasks => 'تابع ما يحتاج إلى إنجازه.';

  @override
  String get projectTasks => 'مهام هذا المشروع.';

  @override
  String get tasksCannotBeAddedToEndedProject =>
      'لا يمكن إضافة مهام إلى مشروع منتهٍ.';

  @override
  String get addTask => 'إضافة مهمة';

  @override
  String get createTask => 'إنشاء مهمة';

  @override
  String get pleaseEnterAllTaskInformation => 'يرجى إدخال جميع معلومات المهمة.';

  @override
  String get taskTitle => 'عنوان المهمة';

  @override
  String get project => 'المشروع';

  @override
  String get priority => 'الأولوية';

  @override
  String get high => 'عالية';

  @override
  String get medium => 'متوسطة';

  @override
  String get low => 'منخفضة';

  @override
  String get deleteTask => 'حذف المهمة';

  @override
  String deleteTaskConfirmation(String taskTitle) {
    return 'هل أنت متأكد أنك تريد حذف المهمة \"$taskTitle\"؟';
  }

  @override
  String get editTask => 'تعديل المهمة';

  @override
  String get pleaseEnterTaskTitle => 'يرجى إدخال عنوان المهمة.';

  @override
  String get assignedTo => 'مسندة إلى';

  @override
  String get date => 'التاريخ';

  @override
  String get clearAll => 'مسح الكل';

  @override
  String get filterTasks => 'تصفية المهام';

  @override
  String get searchTasks => 'البحث عن المهام';

  @override
  String get projectTasksReadOnly => 'انتهى هذا المشروع. المهام للقراءة فقط.';

  @override
  String get change => 'تغيير';

  @override
  String get addingTaskAvailableSoon => 'ستتوفر إضافة مهمة قريبًا.';

  @override
  String get unableToLoadProjectTasks => 'تعذر تحميل مهام المشروع.';

  @override
  String get searchFileNameOrLocation => 'البحث عن اسم الملف أو الموقع';

  @override
  String get allProjectFilesInOnePlace => 'جميع ملفات مشاريعك في مكان واحد.';

  @override
  String get noFilesFound => 'لم يتم العثور على ملفات.';

  @override
  String get unableToLoadFiles => 'تعذر تحميل الملفات.';

  @override
  String get noActiveProjectsForFiles =>
      'لا توجد مشاريع نشطة متاحة لإضافة الملفات.';

  @override
  String get filesCannotBeAddedToEndedProject =>
      'لا يمكن إضافة ملفات إلى مشروع منتهٍ.';

  @override
  String get addFile => 'إضافة ملف';

  @override
  String get projectFiles => 'ملفات المشروع';

  @override
  String get allFilesForThisProjectInOnePlace =>
      'جميع ملفات هذا المشروع في مكان واحد.';

  @override
  String get projectFilesReadOnly => 'انتهى هذا المشروع. الملفات للقراءة فقط.';

  @override
  String get searchProjectFiles => 'البحث في ملفات المشروع';

  @override
  String get fileUploadedSuccessfully => 'تم رفع الملف بنجاح.';

  @override
  String get unableToUploadFile => 'تعذر رفع الملف.';

  @override
  String get unableToLoadProjectFiles => 'تعذر تحميل ملفات المشروع.';

  @override
  String get saveFile => 'حفظ الملف';

  @override
  String get fileName => 'اسم الملف';

  @override
  String get fileNameHint => 'مثال: Structural Drawings.pdf';

  @override
  String get fileType => 'نوع الملف';

  @override
  String get image => 'صورة';

  @override
  String get document => 'مستند';

  @override
  String get fileSize => 'حجم الملف';

  @override
  String get fileSizeHint => 'مثال: 4.2 MB';

  @override
  String get pleaseCompleteAllFields => 'يرجى إكمال جميع الحقول.';

  @override
  String get openFile => 'فتح';

  @override
  String get download => 'تنزيل';

  @override
  String get opening => 'جارٍ الفتح';

  @override
  String get downloading => 'جارٍ التنزيل';

  @override
  String get deleting => 'جارٍ الحذف';

  @override
  String get filters => 'التصفية';

  @override
  String get reset => 'إعادة تعيين';

  @override
  String get close => 'إغلاق';

  @override
  String get profile => 'الملف الشخصي';

  @override
  String get unableToLoadUserProfile => 'تعذر تحميل الملف الشخصي.';

  @override
  String get phone => 'الهاتف';

  @override
  String get about => 'حول';

  @override
  String get aboutOmranDescription =>
      'عمران هو تطبيق لإدارة المشاريع مصمم لمساعدتك على تنظيم المشاريع والمهام والملفات في مكان واحد.';

  @override
  String get version => 'الإصدار';

  @override
  String get contact => 'التواصل';

  @override
  String get settings => 'الإعدادات';

  @override
  String get notifications => 'الإشعارات';

  @override
  String get home => 'الرئيسية';

  @override
  String get goodAfternoon => 'مساء الخير';

  @override
  String get goodEvening => 'مساء الخير';
}
