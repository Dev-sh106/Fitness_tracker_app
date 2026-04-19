import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/activity.dart';
import '../models/bmi_record.dart';

class StorageService {
  static const String _activitiesKey = 'activities_data';
  static const String _bmiHistoryKey = 'bmi_history_data';
  static const String _themeModeKey = 'theme_mode';

  // Save Activities
  Future<void> saveActivities(List<Activity> activities) async {
    final prefs = await SharedPreferences.getInstance();
    final String data = jsonEncode(activities.map((e) => e.toJson()).toList());
    await prefs.setString(_activitiesKey, data);
  }

  // Load Activities
  Future<List<Activity>> loadActivities() async {
    final prefs = await SharedPreferences.getInstance();
    final String? data = prefs.getString(_activitiesKey);
    if (data == null) return [];
    
    final List<dynamic> decoded = jsonDecode(data);
    return decoded.map((e) => Activity.fromJson(e)).toList();
  }

  // Save BMI History
  Future<void> saveBmiHistory(List<BmiRecord> records) async {
    final prefs = await SharedPreferences.getInstance();
    final String data = jsonEncode(records.map((e) => e.toJson()).toList());
    await prefs.setString(_bmiHistoryKey, data);
  }

  // Load BMI History
  Future<List<BmiRecord>> loadBmiHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final String? data = prefs.getString(_bmiHistoryKey);
    if (data == null) return [];
    
    final List<dynamic> decoded = jsonDecode(data);
    return decoded.map((e) => BmiRecord.fromJson(e)).toList();
  }

  // Save Theme Mode (true for dark, false for light)
  Future<void> saveThemeMode(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeModeKey, isDark);
  }

  // Load Theme Mode
  Future<bool> loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_themeModeKey) ?? false;
  }
}
