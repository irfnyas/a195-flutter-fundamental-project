import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    const initializationSettingsAndroid = AndroidInitializationSettings(
      'app_icon',
    );

    await flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(android: initializationSettingsAndroid),
    );
  }

  Future<bool> isAndroidPermissionGranted() async {
    return await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.areNotificationsEnabled() ??
        false;
  }

  Future<bool> requestAndroidNotificationsPermission() async {
    return await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.requestNotificationsPermission() ??
        false;
  }

  Future<bool?> requestPermissions() async {
    final isAndroid = defaultTargetPlatform == TargetPlatform.android;
    if (!isAndroid) return false;

    final androidImplementation =
        flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
    final requestNotificationsPermission =
        await androidImplementation?.requestNotificationsPermission();
    final notificationEnabled = await isAndroidPermissionGranted();
    final requestAlarmEnabled = await requestExactAlarmsPermission();
    return (requestNotificationsPermission ?? false) &&
        notificationEnabled &&
        requestAlarmEnabled;
  }

  Future<bool> requestExactAlarmsPermission() async {
    return await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.requestExactAlarmsPermission() ??
        false;
  }

  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    required String payload,
    String channelId = '1',
    String channelName = 'Restaurant Notification',
  }) async {
    final androidPlatformChannelSpecifics = AndroidNotificationDetails(
      channelId,
      channelName,
      importance: Importance.max,
      priority: Priority.high,
    );

    final notificationDetails = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      notificationDetails,
      payload: payload,
    );
  }

  Future<void> configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final timeZoneName = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }

  Future<tz.TZDateTime> nextDaily() async {
    await configureLocalTimeZone();
    final now = tz.TZDateTime.now(tz.local);

    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      11,
    );

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(
        const Duration(days: 1),
      );
    }

    return scheduledDate;
  }

  Future<void> scheduleDailyNotification({
    required int id,
    String channelId = '1',
    String channelName = 'Restaurant Notification',
  }) async {
    final androidPlatformChannelSpecifics = AndroidNotificationDetails(
      channelId,
      channelName,
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    final notificationDetails = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      'Don\'t forget your lunch!',
      'Click to see restaurant recommendation',
      await nextDaily(),
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.wallClockTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }
}
