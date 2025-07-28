import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:grateful_app/providers/gratitude_provider.dart';
import 'package:grateful_app/theme/app_theme.dart';
import 'package:grateful_app/widgets/empty_state_widget.dart';
import 'package:grateful_app/widgets/gratitude_entry_card.dart';

class JournalScreen extends StatefulWidget {
  const JournalScreen({super.key});

  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {

  void _showAddEntryModal(BuildContext context) {
    final textController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
            top: 24,
            left: 24,
            right: 24,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "What are you grateful for?",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: textController,
                autofocus: true,
                maxLines: 4,
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(
                  hintText: "Today, I'm grateful for...",
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    final text = textController.text;
                    if (text.trim().isNotEmpty) {
                      context.read<GratitudeProvider>().addEntry(text);
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Save Moment'),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = context.watch<ThemeNotifier>();
    final isDark = themeNotifier.themeMode == ThemeMode.dark;



    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Journal',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            tooltip: 'Toggle Theme',
            icon: Icon(isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined),
            onPressed: () => themeNotifier.toggleTheme(!isDark),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Consumer<GratitudeProvider>(
        builder: (context, gratitudeProvider, child) {
          if (gratitudeProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (gratitudeProvider.entries.isEmpty) {
            return const EmptyStateWidget();
          }
          return ListView.builder(
            padding: const EdgeInsets.only(top: 8, bottom: 80),
            itemCount: gratitudeProvider.entries.length,
            itemBuilder: (context, index) {
              final entry = gratitudeProvider.entries[index];
              return Dismissible(
                key: ValueKey(entry.id),
                onDismissed: (direction) {
                  context.read<GratitudeProvider>().deleteEntry(entry.id);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text("Entry deleted"),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      margin: const EdgeInsets.all(16),
                    ),
                  );
                },
                background: Container(
                  color: Theme.of(context).colorScheme.error,
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  alignment: Alignment.centerRight,
                  child: Icon(
                    Icons.delete_outline,
                    color: Theme.of(context).colorScheme.onError,
                  ),
                ),
                direction: DismissDirection.endToStart,
                child: GratitudeEntryCard(entry: entry),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddEntryModal(context),
        tooltip: 'Add new entry',
        child: const Icon(Icons.add_rounded),
      ),
    );
  }
}