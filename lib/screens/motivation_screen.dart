import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:grateful_app/providers/gratitude_provider.dart';

class MotivationScreen extends StatefulWidget {
  const MotivationScreen({super.key});

  @override
  State<MotivationScreen> createState() => _MotivationScreenState();
}

class _MotivationScreenState extends State<MotivationScreen> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<GratitudeProvider>();
      if (provider.currentMotivation == null) {
        provider.getNewMotivation();
      }
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // App has come to the foreground
      context.read<GratitudeProvider>().getNewMotivation();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final provider = context.watch<GratitudeProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Daily Motivation',
          style: theme.textTheme.headlineMedium?.copyWith(
            color: theme.colorScheme.onSurface,
          ),
        ),
        centerTitle: false,
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Card(
                elevation: 4.0, // Give it a bit more lift
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      Icon(
                        Icons.format_quote_rounded,
                        size: 40,
                        color: theme.colorScheme.primary.withOpacity(0.8),
                      ),
                      const SizedBox(height: 16),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 500),
                        transitionBuilder: (Widget child, Animation<double> animation) {
                          return FadeTransition(opacity: animation, child: child);
                        },
                        child: Text(
                          provider.currentMotivation ?? "Loading...",
                          key: ValueKey<String>(provider.currentMotivation ?? ""),
                          textAlign: TextAlign.center,
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontStyle: FontStyle.italic,
                            height: 1.5,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      if (provider.motivationSource.isNotEmpty)
                        Text(
                          '- ${provider.motivationSource}',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),

              ElevatedButton.icon(
                onPressed: () {
                  context.read<GratitudeProvider>().getNewMotivation();
                },
                icon: const Icon(Icons.refresh_rounded),
                label: const Text('New Quote'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}