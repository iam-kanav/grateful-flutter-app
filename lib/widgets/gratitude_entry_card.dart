

import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import the intl package
import 'package:grateful_app/models/gratitude_entry.dart'; // Import the real model

class GratitudeEntryCard extends StatelessWidget {

  final GratitudeEntry entry;

  const GratitudeEntryCard({
    super.key,
    required this.entry,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final formattedDate = DateFormat.yMMMMd().format(entry.timestamp);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              entry.text,
              style: theme.textTheme.bodyLarge?.copyWith(height: 1.5),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  size: 14,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(

                  formattedDate,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}