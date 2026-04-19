import 'package:flutter/material.dart';
import '../models/activity.dart';
import '../models/bmi_record.dart';
import '../services/storage_service.dart';

class FitnessProvider extends ChangeNotifier {
  final StorageService _storageService = StorageService();
  
  List<Activity> _activities = [];
  List<BmiRecord> _bmiHistory = [];

  List<Activity> get activities => _activities;
  List<BmiRecord> get bmiHistory => _bmiHistory;

  int get totalMinutesActive {
    return _activities.where((a) => a.isCompleted).fold(0, (sum, item) => sum + item.durationMinutes);
  }

  int get totalCaloriesBurned {
    return _activities.where((a) => a.isCompleted).fold(0, (sum, item) => sum + item.caloriesBurned);
  }

  FitnessProvider() {
    _loadData();
  }

  Future<void> _loadData() async {
    _activities = await _storageService.loadActivities();
    _bmiHistory = await _storageService.loadBmiHistory();
    notifyListeners();
  }

  // Activity Methods
  void addActivity(String name, int durationMinutes) {
    // Basic rough estimate for calories (e.g. 8 calories per minute)
    int estimatedCalories = durationMinutes * 8;
    
    final newActivity = Activity(
      id: DateTime.now().toString(),
      name: name,
      durationMinutes: durationMinutes,
      caloriesBurned: estimatedCalories,
    );
    _activities.add(newActivity);
    _saveActivities();
    notifyListeners();
  }

  void toggleActivityCompletion(String id) {
    final index = _activities.indexWhere((a) => a.id == id);
    if (index >= 0) {
      _activities[index].isCompleted = !_activities[index].isCompleted;
      _saveActivities();
      notifyListeners();
    }
  }

  void deleteActivity(String id) {
    _activities.removeWhere((a) => a.id == id);
    _saveActivities();
    notifyListeners();
  }

  void _saveActivities() {
    _storageService.saveActivities(_activities);
  }

  // BMI Methods
  void addBmiRecord(double height, double weight, double bmi, String category) {
    final record = BmiRecord(
      id: DateTime.now().toString(),
      date: DateTime.now(),
      height: height,
      weight: weight,
      bmi: bmi,
      category: category,
    );
    _bmiHistory.add(record);
    
    // Keep only last 10 records for the graph
    if (_bmiHistory.length > 10) {
      _bmiHistory.removeAt(0);
    }
    
    _storageService.saveBmiHistory(_bmiHistory);
    notifyListeners();
  }
}
