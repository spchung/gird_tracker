import 'package:flutter/material.dart';

class Session {
  bool isPlaceholder;
  int? id;
  DateTime? dateTime;
  int? workoutGroupId;
  String? workoutGroupName;

  Session({
    required this.dateTime,
    required this.workoutGroupId,
    this.isPlaceholder = false,
    this.workoutGroupName,
    this.id,
  });

  Session.placeholder() : isPlaceholder = true;

  Map<String, dynamic> toMap() {
    return {
      'dateTime': dateTime!.millisecondsSinceEpoch,
      'workout_group_id': workoutGroupId,
    };
  }

  factory Session.fromMap(Map<String, dynamic> map) {
    return Session(
      id: map['id'],
      dateTime: DateTime.fromMillisecondsSinceEpoch(int.tryParse(map['datetime']) ?? 0),
      workoutGroupId: map['workout_group_id'],
      workoutGroupName: map['name'],
    );
  }
}

class Workout {
  String name;
  Color color;

  Workout({
    required this.name,
    required this.color,
  });
}
