import 'package:flutter/material.dart';

class Habit {
  final String id;
  final String name;
  final String description;
  final int durationMinutes;
  final IconData icon;
  final Color color;
  final String type; // 'build' or 'quit'
  final int frequency;
  final String interval; // 'daily', 'weekly', 'monthly'
  final bool hasReminder;
  final DateTime createdAt;
  final DateTime? lastCompleted;

  Habit({
    required this.id,
    required this.name,
    required this.description,
    required this.durationMinutes,
    required this.icon,
    required this.color,
    required this.type,
    required this.frequency,
    required this.interval,
    this.hasReminder = false,
    DateTime? createdAt,
    this.lastCompleted,
  }) : createdAt = createdAt ?? DateTime.now();

  // Convert Habit to Map for storage
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'durationMinutes': durationMinutes,
      'icon': icon.codePoint,
      'color': color.hashCode,
      'type': type,
      'frequency': frequency,
      'interval': interval,
      'hasReminder': hasReminder,
      'createdAt': createdAt.toIso8601String(),
      'lastCompleted': lastCompleted?.toIso8601String(),
    };
  }

  // Create Habit from Map
  factory Habit.fromMap(Map<String, dynamic> map) {
    return Habit(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      durationMinutes: map['durationMinutes'],
      icon: IconData(map['icon'], fontFamily: 'MaterialIcons'),
      color: Color(map['color']),
      type: map['type'],
      frequency: map['frequency'],
      interval: map['interval'],
      hasReminder: map['hasReminder'],
      createdAt: DateTime.parse(map['createdAt']),
      lastCompleted: map['lastCompleted'] != null
          ? DateTime.parse(map['lastCompleted'])
          : null,
    );
  }

  // Create a copy of Habit with some fields updated
  Habit copyWith({
    String? name,
    String? description,
    int? durationMinutes,
    IconData? icon,
    Color? color,
    String? type,
    int? frequency,
    String? interval,
    bool? hasReminder,
    DateTime? lastCompleted,
  }) {
    return Habit(
      id: id,
      name: name ?? this.name,
      description: description ?? this.description,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      type: type ?? this.type,
      frequency: frequency ?? this.frequency,
      interval: interval ?? this.interval,
      hasReminder: hasReminder ?? this.hasReminder,
      createdAt: createdAt,
      lastCompleted: lastCompleted ?? this.lastCompleted,
    );
  }
}
