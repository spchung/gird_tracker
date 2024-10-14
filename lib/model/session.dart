import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lets_git_it/model/exercise.dart';

class Session {
  bool isPlaceholder;
  int? id;
  DateTime? dateTime;
  int? workoutGroupId;
  String? workoutGroupName;
  List<Exercise>? exercises;

  Session({
    required this.dateTime,
    required this.workoutGroupId,
    this.isPlaceholder = false,
    this.workoutGroupName,
    this.id,
    this.exercises,
  });

  Session.placeholder() : isPlaceholder = true;

  Map<String, dynamic> toMap() {
    List<Exercise> exercises = [
      Exercise(name: 'Bench Press', description: 'test', workoutGroupId: 1),
      Exercise(name: 'Squats', description: 'test', workoutGroupId: 1),
      Exercise(name: 'Deadlift', description: 'test', workoutGroupId: 1),
    ];
    return {
      'dateTime': dateTime!.millisecondsSinceEpoch,
      'workout_group_id': workoutGroupId,
      'exercises': jsonEncode(exercises.map((e) => e.toMap()).toList()),
    };
  }

  factory Session.fromMap(Map<String, dynamic> map) {
    return Session(
      id: map['id'],
      dateTime: DateTime.fromMillisecondsSinceEpoch(int.tryParse(map['datetime']) ?? 0),
      workoutGroupId: map['workout_group_id'],
      workoutGroupName: map['name'],
      exercises: map['exercises'] != null ? (jsonDecode(map['exercises']) as List).map((e) => Exercise.fromMap(e)).toList() : [],
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
