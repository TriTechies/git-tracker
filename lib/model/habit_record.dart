class HabitRecord {
  final String id;
  final String habitId;
  final DateTime createdAt;

  HabitRecord({
    required this.id,
    required this.habitId,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'habitId': habitId,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory HabitRecord.fromMap(Map<String, dynamic> map) {
    return HabitRecord(
      id: map['id'],
      habitId: map['habitId'],
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}