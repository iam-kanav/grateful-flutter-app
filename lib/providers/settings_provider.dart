import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:grateful_app/services/notification_service.dart';
import 'package:workmanager/workmanager.dart';

class SettingsProvider with ChangeNotifier {
  static const String dailyNotifKey = 'daily_notif_enabled';
  static const String dailyNotifHourKey = 'daily_notif_hour';
  static const String dailyNotifMinuteKey = 'daily_notif_minute';
  static const String randomNotifKey = 'random_notif_enabled';
  static const String randomNotifIntervalKey = 'random_notif_interval';
  static const String randomTaskName = "gratefulRandomMotivationTask";

  bool _isDailyEnabled = false;
  TimeOfDay _scheduledTime = const TimeOfDay(hour: 9, minute: 0);
  bool _isRandomEnabled = false;
  int _randomNotificationInterval = 60; // in minutes

  bool get isDailyEnabled => _isDailyEnabled;
  TimeOfDay get scheduledTime => _scheduledTime;
  bool get isRandomEnabled => _isRandomEnabled;
  int get randomNotificationInterval => _randomNotificationInterval;

  final NotificationService _notificationService = NotificationService();

  SettingsProvider() {
    loadSettings();
  }

  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _isDailyEnabled = prefs.getBool(dailyNotifKey) ?? false;
    final hour = prefs.getInt(dailyNotifHourKey) ?? 9;
    final minute = prefs.getInt(dailyNotifMinuteKey) ?? 0;
    _scheduledTime = TimeOfDay(hour: hour, minute: minute);
    _isRandomEnabled = prefs.getBool(randomNotifKey) ?? false;
    _randomNotificationInterval = prefs.getInt(randomNotifIntervalKey) ?? 60;
    notifyListeners();
  }

  Future<void> toggleDailyNotifications(bool enabled) async {
    _isDailyEnabled = enabled;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(dailyNotifKey, enabled);

    if (enabled) {
      _notificationService.scheduleDailyNotification(
        time: _scheduledTime,
        title: 'Your Daily Gratitude Reminder ☀️',
        body: 'What are you grateful for today? Open Grateful to write it down.',
      );
    } else {
      _notificationService.cancelDailyNotification();
    }
    notifyListeners();
  }

  Future<void> setScheduledTime(TimeOfDay time) async {
    _scheduledTime = time;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(dailyNotifHourKey, time.hour);
    await prefs.setInt(dailyNotifMinuteKey, time.minute);

    if (_isDailyEnabled) {
      await toggleDailyNotifications(true);
    }
    notifyListeners();
  }
      
  Future<void> toggleRandomNotifications(bool enabled) async {
    _isRandomEnabled = enabled;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(randomNotifKey, enabled);

    if (enabled) {
      Workmanager().registerPeriodicTask(
        randomTaskName,
        randomTaskName,
        frequency: Duration(minutes: _randomNotificationInterval),
        // --- THIS IS THE FINAL FIX ---
        // The `constraints` parameter is optional. By omitting it,
        // we specify that there are no constraints for this task.
      );
    } else {
      Workmanager().cancelByUniqueName(randomTaskName);
    }
    notifyListeners();
  }

  Future<void> setRandomNotificationInterval(int interval) async {
    _randomNotificationInterval = interval;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(randomNotifIntervalKey, interval);

    if (_isRandomEnabled) {
      await toggleRandomNotifications(true);
    }
    notifyListeners();
  }
}