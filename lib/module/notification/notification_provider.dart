import 'package:flutter/widgets.dart';

import '../../data/model/restaurant_model.dart';
import 'notification_service.dart';

class NotificationProvider extends ChangeNotifier {
  NotificationProvider(this.flutterNotificationService);

  final NotificationService flutterNotificationService;

  int notificationId = 0;
  bool? _permission = false;
  bool? get permission => _permission;

  Future<void> requestPermissions() async {
    _permission = await flutterNotificationService.requestPermissions();
    notifyListeners();
  }

  void showNotification(Restaurant restaurant) {
    notificationId += 1;
    flutterNotificationService.showNotification(
      id: notificationId,
      title: 'New lunch spot for you: ${restaurant.name}',
      body: restaurant.description ?? '',
      payload: restaurant.id ?? '',
    );
  }

  void scheduleDailyNotification() {
    notificationId += 1;
    flutterNotificationService.scheduleDailyNotification(id: notificationId);
    checkPendingNotificationRequests();
  }

  Future<void> checkPendingNotificationRequests() async {
    final pendingNotificationRequests = await flutterNotificationService
        .flutterLocalNotificationsPlugin
        .pendingNotificationRequests();

    for (var i = 0; i < pendingNotificationRequests.length; i++) {
      if (i == pendingNotificationRequests.length - 1) break;
      await flutterNotificationService.flutterLocalNotificationsPlugin.cancel(
        pendingNotificationRequests[i].id,
      );
    }
  }

  Future<void> cancelAllPendingNotifications() async {
    await flutterNotificationService.flutterLocalNotificationsPlugin
        .cancelAll();
  }
}
