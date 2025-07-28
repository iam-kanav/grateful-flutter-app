import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grateful_app/models/gratitude_entry.dart';
import 'package:grateful_app/services/hive_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GratitudeProvider with ChangeNotifier {
  final HiveService _hiveService = HiveService();

  List<GratitudeEntry> _entries = [];
  bool _isLoading = true;
  String? _currentMotivation; // <-- NEW: State for the motivation message
  String _motivationSource = ""; // <-- NEW: To track where the motivation came from


  List<GratitudeEntry> get entries => _entries;
  bool get isLoading => _isLoading;
  String? get currentMotivation => _currentMotivation; // <-- NEW
  String get motivationSource => _motivationSource; // <-- NEW

  GratitudeProvider() {
    loadEntries();
  }


  Future<void> loadEntries() async {
    _isLoading = true;
    notifyListeners();
    _entries = _hiveService.getEntries();
    _isLoading = false;
    notifyListeners();
  }

  Future<void> addEntry(String text) async {
    final newEntry = GratitudeEntry(
      text: text,
      timestamp: DateTime.now(),
    );
    await _hiveService.addEntry(newEntry);
    await loadEntries();
  }

  Future<void> deleteEntry(String id) async {
    await _hiveService.deleteEntry(id);
    await loadEntries();
  }
  

  Future<void> getNewMotivation() async {
    final List<String> motivationPool = [];


    try {
      final String response = await rootBundle.loadString('assets/motivation_quotes.json');
      final data = await json.decode(response);
      final List<String> quotes = List<String>.from(data['quotes']);
      motivationPool.addAll(quotes);
    } catch (e) {
      print("Error loading motivation quotes: $e");
    }


    final List<String> userEntriesText = _entries.map((entry) => entry.text).toList();
    motivationPool.addAll(userEntriesText);


    if (motivationPool.isEmpty) {
      _currentMotivation = "Tap the '+' on the Journal tab to add your first gratitude moment!";
      _motivationSource = "App";
    } else {
      final random = Random();
      final index = random.nextInt(motivationPool.length);
      _currentMotivation = motivationPool[index];
      

      if (index < (motivationPool.length - userEntriesText.length)) {
        _motivationSource = "Anonymous"; // It's a predefined quote
      } else {
        _motivationSource = "From your journal"; // It's one of the user's entries
      }
    }
    
    // Save the current motivation to SharedPreferences for the homescreen widget
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('currentMotivation', _currentMotivation ?? "");

    notifyListeners(); // Notify the UI to update with the new motivation
  }
}