// lib/services/notification_service.dart

import 'package:flutter/material.dart'; // Import for TimeOfDay
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static const dailyScheduledId = 0;

  NotificationService._privateConstructor();
  static final NotificationService _instance = NotificationService._privateConstructor();
  factory NotificationService() => _instance;

  Future<void> init() async {
    tz.initializeTimeZones();
    final String timeZoneName = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings();
    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
    await _requestPermissions();
  }

  Future<void> _requestPermissions() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(const AndroidNotificationChannel(
            'grateful_channel', 'Grateful Notifications',
            description: 'Channel for Grateful app notifications',
            importance: Importance.max));
    
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(alert: true, badge: true, sound: true);
  }

  tz.TZDateTime _nextInstanceOfTime(TimeOfDay time) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(
        tz.local, now.year, now.month, now.day, time.hour, time.minute);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  Future<void> scheduleDailyNotification({
    required TimeOfDay time,
    required String title,
    required String body,
  }) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      dailyScheduledId,
      title,
      body,
      _nextInstanceOfTime(time),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'grateful_daily_channel',
          'Daily Gratitude',
          channelDescription: 'Scheduled daily reminders from Grateful.',
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      // --- THE FIX: The problematic parameter has been REMOVED ---
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'grateful_random_channel',
          'Random Motivation',
          channelDescription: 'Spontaneous motivational messages.',
          importance: Importance.defaultImportance,
          priority: Priority.defaultPriority,
        ),
      ),
    );
  }

  Future<void> cancelDailyNotification() async {
    await flutterLocalNotificationsPlugin.cancel(dailyScheduledId);
  }
}