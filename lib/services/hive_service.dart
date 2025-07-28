

import 'package:hive_flutter/hive_flutter.dart';
import 'package:grateful_app/models/gratitude_entry.dart';


class HiveService {

  static const String _boxName = "gratitudeBox";


  HiveService._privateConstructor();

  static final HiveService _instance = HiveService._privateConstructor();

  factory HiveService() => _instance;

  late Box<GratitudeEntry> _box;



  Future<void> init() async {

    Hive.registerAdapter(GratitudeEntryAdapter());

    _box = await Hive.openBox<GratitudeEntry>(_boxName);
  }



  List<GratitudeEntry> getEntries() {
    final entries = _box.values.toList();

    entries.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    return entries;
  }




  Future<void> addEntry(GratitudeEntry entry) async {
    await _box.put(entry.id, entry);
  }



  Future<void> updateEntry(GratitudeEntry entry) async {
    await entry.save();
  }


  Future<void> deleteEntry(String id) async {
    await _box.delete(id);
  }


  void dispose() {
    _box.close();
  }
}