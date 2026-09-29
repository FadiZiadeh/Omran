import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:omran/core/models/notification_model.dart';


class NotificationService {
  final FirebaseMessaging _messaging =
      FirebaseMessaging.instance;

  final FlutterLocalNotificationsPlugin _localNotifications =
  FlutterLocalNotificationsPlugin();

  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  static const AndroidNotificationChannel _channel =
  AndroidNotificationChannel(
    'omran_notifications',
    'Omran Notifications',
    description: 'Notifications for the Omran app',
    importance: Importance.high,
  );

  Future<void> initialize() async {
    try {
      const androidSettings =
      AndroidInitializationSettings('@mipmap/ic_launcher');

      const initializationSettings = InitializationSettings(
        android: androidSettings,
      );

      await _localNotifications.initialize(
        settings: initializationSettings,
      );

      await _localNotifications
          .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(_channel);

      await _messaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      FirebaseMessaging.onMessage.listen(
            (RemoteMessage message) {
          final notification = message.notification;

          if (notification != null) {
            _showLocalNotification(
              title: notification.title,
              body: notification.body,
            );
          }
        },
      );

      FirebaseMessaging.onMessageOpenedApp.listen(
            (RemoteMessage message) {
          _handleNotificationTap(message);
        },
      );

      try {
        final initialMessage =
        await _messaging.getInitialMessage();

        if (initialMessage != null) {
          _handleNotificationTap(initialMessage);
        }
      } catch (e) {
        // ignore: avoid_print
        print(
          'Unable to get initial notification: $e',
        );
      }
    } catch (e) {
      // ignore: avoid_print
      print(
        'Notification service initialization failed: $e',
      );
    }
  }

  Future<void> saveTokenForCurrentUser() async {
    try {
      final firebaseUser =
          FirebaseAuth.instance.currentUser;

      if (firebaseUser == null) {
        return;
      }

      final token = await _messaging.getToken();

      if (token == null) {
        return;
      }

      await _firestore
          .collection('users')
          .doc(firebaseUser.uid)
          .update({
        'fcmToken': token,
      });

      // ignore: avoid_print
      print('FCM token saved successfully.');
    } catch (e) {
      // ignore: avoid_print
      print(
        'Unable to save FCM token: $e',
      );
    }
  }

  void _handleNotificationTap(
      RemoteMessage message,
      ) {
    // Notification navigation will be implemented later.
  }

  Future<void> _showLocalNotification({
    String? title,
    String? body,
  }) async {
    const androidDetails =
    AndroidNotificationDetails(
      'omran_notifications',
      'Omran Notifications',
      channelDescription:
      'Notifications for the Omran app',
      importance: Importance.high,
      priority: Priority.high,
    );

    const notificationDetails =
    NotificationDetails(
      android: androidDetails,
    );

    await _localNotifications.show(
      id: DateTime.now()
          .millisecondsSinceEpoch ~/
          1000,
      title: title,
      body: body,
      notificationDetails:
      notificationDetails,
    );
  }
  Future<void> createNotification(
      NotificationModel notification,
      ) async {
    final document = _firestore
        .collection('notifications')
        .doc();

    final notificationWithId = NotificationModel(
      id: document.id,
      userId: notification.userId,
      title: notification.title,
      body: notification.body,
      type: notification.type,
      projectId: notification.projectId,
      taskId: notification.taskId,
      isRead: notification.isRead,
      createdAt: notification.createdAt,
    );

    await document.set(
      notificationWithId.toFirestore(),
    );
  }
  Stream<List<NotificationModel>> getUserNotifications(
      String userId,
      ) {
    return _firestore
        .collection('notifications')
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) {
      final notifications = snapshot.docs.map((document) {
        return NotificationModel.fromFirestore(document);
      }).toList();

      notifications.sort(
            (a, b) => b.createdAt.compareTo(a.createdAt),
      );

      return notifications;
    });
  }
  Future<void> markAsRead(
      String notificationId,
      ) async {
    await _firestore
        .collection('notifications')
        .doc(notificationId)
        .update({
      'isRead': true,
    });
  }
  Future<void> markAllAsRead(
      String userId,
      ) async {
    final snapshot = await _firestore
        .collection('notifications')
        .where('userId', isEqualTo: userId)
        .where('isRead', isEqualTo: false)
        .get();

    final batch = _firestore.batch();

    for (final document in snapshot.docs) {
      batch.update(
        document.reference,
        {
          'isRead': true,
        },
      );
    }

    await batch.commit();
  }

}