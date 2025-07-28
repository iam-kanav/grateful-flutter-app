import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'package:grateful_app/providers/gratitude_provider.dart';
import 'package:grateful_app/services/hive_service.dart';
import 'package:grateful_app/theme/app_theme.dart';
import 'package:grateful_app/screens/main_screen.dart'; // Import the new MainScreen
import 'services/notification_service.dart';
import 'providers/settings_provider.dart';

// Add this to lib/main.dart (outside the main() function and classes)

import 'dart:math';
// ... other imports ...
import 'package:workmanager/workmanager.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    // We need to initialize services here again because this runs in a separate isolate.
    await Hive.initFlutter();
    await HiveService().init();
    final provider = GratitudeProvider();
    await provider.loadEntries(); // Load entries to get a quote

    // Get a motivation
    await provider.getNewMotivation();
    final motivation = provider.currentMotivation;

    if (motivation != null) {
      // Use a random number to decide whether to show a notification this time.
      // This makes it feel more spontaneous.
      final showNotification = Random().nextBool();
      if (showNotification) {
        final notificationService = NotificationService();
        await notificationService.init(); // Init the service in the isolate
        await notificationService.showNotification(
          id: 1, // Use a different ID from the scheduled one
          title: "A Moment for You ✨",
          body: motivation,
        );
      }
    }
    return Future.value(true);
  });
}

void main() async {

  WidgetsFlutterBinding.ensureInitialized();



  await Hive.initFlutter();



  await HiveService().init();

  await Workmanager().initialize(
    callbackDispatcher,
    isInDebugMode: true
  );

  final themeNotifier = ThemeNotifier();
  await themeNotifier.loadTheme();


  runApp(
    MultiProvider(
      providers: [

        ChangeNotifierProvider.value(value: themeNotifier),
        

        ChangeNotifierProvider(create: (_) => GratitudeProvider()),

        ChangeNotifierProvider(create: (_) => SettingsProvider()),
      ],
      child: const GratefulApp(),
    ),
  );
}


class GratefulApp extends StatelessWidget {
  const GratefulApp({super.key});

  @override
  Widget build(BuildContext context) {
 

    final themeNotifier = context.watch<ThemeNotifier>();

    return MaterialApp(

      title: 'Grateful',
      debugShowCheckedModeBanner: false,


      theme: AppTheme.lightTheme,       // The theme to use for light mode.
      darkTheme: AppTheme.darkTheme,    // The theme to use for dark mode.
      themeMode: themeNotifier.themeMode, // Controlled by our ThemeNotifier.




      home: const MainScreen(),
    );
  }
}
