class Activity {
  final String id;
  final String name;
  final int durationMinutes;
  bool isCompleted;

  Activity({
    required this.id,
    required this.name,
    required this.durationMinutes,
    this.isCompleted = false,
  });
}
