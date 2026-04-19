class BmiRecord {
  final String id;
  final DateTime date;
  final double height;
  final double weight;
  final double bmi;
  final String category;

  BmiRecord({
    required this.id,
    required this.date,
    required this.height,
    required this.weight,
    required this.bmi,
    required this.category,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'height': height,
      'weight': weight,
      'bmi': bmi,
      'category': category,
    };
  }

  factory BmiRecord.fromJson(Map<String, dynamic> json) {
    return BmiRecord(
      id: json['id'],
      date: DateTime.parse(json['date']),
      height: json['height'],
      weight: json['weight'],
      bmi: json['bmi'],
      category: json['category'],
    );
  }
}
