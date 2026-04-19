class Activity {
  final String id;
  final String name;
  final int durationMinutes;
  bool isCompleted;
  final int caloriesBurned;

  Activity({
    required this.id,
    required this.name,
    required this.durationMinutes,
    this.isCompleted = false,
    required this.caloriesBurned,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'durationMinutes': durationMinutes,
      'isCompleted': isCompleted,
      'caloriesBurned': caloriesBurned,
    };
  }

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      id: json['id'],
      name: json['name'],
      durationMinutes: json['durationMinutes'],
      isCompleted: json['isCompleted'],
      caloriesBurned: json['caloriesBurned'] ?? 0,
    );
  }
}
