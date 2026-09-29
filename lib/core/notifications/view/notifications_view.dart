import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:omran/core/models/notification_model.dart';
import 'package:omran/core/notifications/notification_service.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    final firebaseUser =
        FirebaseAuth.instance.currentUser;

    if (firebaseUser == null) {
      return const Scaffold(
        body: Center(
          child: Text('User not found.'),
        ),
      );
    }

    final notificationService = NotificationService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          StreamBuilder<List<NotificationModel>>(
            stream: notificationService
                .getUserNotifications(firebaseUser.uid),
            builder: (context, snapshot) {
              final notifications =
                  snapshot.data ?? [];

              final hasUnread = notifications.any(
                    (notification) => !notification.isRead,
              );

              if (!hasUnread) {
                return const SizedBox();
              }

              return TextButton(
                onPressed: () async {
                  await notificationService
                      .markAllAsRead(firebaseUser.uid);
                },
                child: const Text('Mark all read'),
              );
            },
          ),

        ],
      ),
      body: StreamBuilder<List<NotificationModel>>(
        stream: notificationService
            .getUserNotifications(firebaseUser.uid),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text(
                'Unable to load notifications.',
              ),
            );
          }

          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final notifications =
              snapshot.data ?? [];

          if (notifications.isEmpty) {
            return _buildEmptyState(context);
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final notification =
              notifications[index];

              return _buildNotificationCard(
                context,
                notification,
                notificationService,
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildNotificationCard(
      BuildContext context,
      NotificationModel notification,
      NotificationService notificationService,
      ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () async {
          if (!notification.isRead) {
            await notificationService.markAsRead(
              notification.id,
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: notification.isRead
                    ? Theme.of(context)
                    .colorScheme
                    .surfaceContainerHighest
                    : Theme.of(context)
                    .colorScheme
                    .primaryContainer,
                child: Icon(
                  _getNotificationIcon(
                    notification.type,
                  ),
                  color: notification.isRead
                      ? Theme.of(context)
                      .colorScheme
                      .onSurfaceVariant
                      : Theme.of(context)
                      .colorScheme
                      .primary,
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            notification.title,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                              fontWeight:
                              notification.isRead
                                  ? FontWeight.w500
                                  : FontWeight.bold,
                            ),
                          ),
                        ),

                        if (!notification.isRead)
                          Container(
                            width: 9,
                            height: 9,
                            decoration:
                            BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary,
                            ),
                          ),
                      ],
                    ),

                    const SizedBox(height: 6),

                    Text(
                      notification.body,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium,
                    ),

                    const SizedBox(height: 8),

                    Text(
                      _formatDate(
                        notification.createdAt,
                      ),
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment:
          MainAxisAlignment.center,
          children: [
            Icon(
              Icons.notifications_none,
              size: 64,
              color: Theme.of(context)
                  .colorScheme
                  .onSurfaceVariant,
            ),

            const SizedBox(height: 16),

            Text(
              'No notifications',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              'You are all caught up.',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium,
            ),
          ],
        ),
      ),
    );
  }

  IconData _getNotificationIcon(String type) {
    switch (type) {
      case 'task':
        return Icons.task_outlined;

      case 'project':
        return Icons.business_outlined;

      case 'file':
        return Icons.folder_outlined;

      default:
        return Icons.notifications_outlined;
    }
  }

  String _formatDate(DateTime date) {
    final day =
    date.day.toString().padLeft(2, '0');

    final month =
    date.month.toString().padLeft(2, '0');

    final year =
    date.year.toString();

    final hour =
    date.hour.toString().padLeft(2, '0');

    final minute =
    date.minute.toString().padLeft(2, '0');

    return '$day/$month/$year • $hour:$minute';
  }

}