import 'package:flutter/material.dart';

class LoggedWorkout {
  bool isPlaceholder;
  DateTime? dateTime;
  Workout? workout;

  LoggedWorkout({
    required this.dateTime,
    required this.workout,
    this.isPlaceholder = false,
  });

  LoggedWorkout.placeholder() : isPlaceholder = true;
}

class Workout {
  String name;
  Color color;

  Workout({
    required this.name,
    required this.color,
  });
}
