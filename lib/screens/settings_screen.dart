// lib/screens/settings_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:grateful_app/providers/settings_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsProvider = context.watch<SettingsProvider>();
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: theme.textTheme.headlineMedium,
        ),
        centerTitle: false,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Text('Notifications', style: theme.textTheme.titleLarge?.copyWith(color: theme.colorScheme.primary)),
          const SizedBox(height: 8),
          SwitchListTile(
            title: const Text('Daily Reminder'),
            subtitle: const Text('Get a reminder at a specific time each day.'),
            value: settingsProvider.isDailyEnabled,
            onChanged: (value) {
              settingsProvider.toggleDailyNotifications(value);
            },
          ),
          ListTile(
            title: const Text('Reminder Time'),
            subtitle: Text(settingsProvider.scheduledTime.format(context)),
            trailing: const Icon(Icons.arrow_forward_ios),
            enabled: settingsProvider.isDailyEnabled,
            onTap: () async {
              final newTime = await showTimePicker(
                context: context,
                initialTime: settingsProvider.scheduledTime,
              );
              if (newTime != null) {
                settingsProvider.setScheduledTime(newTime);
              }
            },
          ),
          const Divider(height: 32),
          SwitchListTile(
            title: const Text('Spontaneous Motivation'),
            subtitle: const Text('Receive random motivational quotes throughout the day.'),
            value: settingsProvider.isRandomEnabled,
            onChanged: (value) {
              settingsProvider.toggleRandomNotifications(value);
            },
          ),
          ListTile(
            title: const Text('Interval'),
            trailing: DropdownButton<int>(
              value: settingsProvider.randomNotificationInterval,
              items: [15, 30, 60, 180, 360, 720].map((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text(value < 60 ? '$value minutes' : '${value ~/ 60} hours'),
                );
              }).toList(),
              onChanged: settingsProvider.isRandomEnabled
                  ? (int? newValue) {
                      if (newValue != null) {
                        settingsProvider.setRandomNotificationInterval(newValue);
                      }
                    }
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}