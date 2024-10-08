import 'package:flutter/material.dart';
import 'package:lets_git_it/model/workout.dart';

var headers = [
  'dateTime',
  'workout'
];

final legs = Workout(name: 'Legs', color: Colors.blue);
final chest = Workout(name: 'Chest', color: Colors.red);
final back = Workout(name: 'Back', color: Colors.green);
final arms = Workout(name: 'Arms', color: Colors.yellow);
final shoulders = Workout(name: 'Shoulders', color: Colors.orange);
final rest = Workout(name: 'Rest', color: Colors.grey);

var tempData = [
  // LoggedWorkout(dateTime: DateTime(2024, 1, 1, 10, 10), workout: legs),
  // LoggedWorkout(dateTime: DateTime(2024, 1, 2, 10, 10), workout: chest),
  LoggedWorkout(dateTime: DateTime(2024, 1, 3, 10, 10), workout: back),
  LoggedWorkout(dateTime: DateTime(2024, 1, 4, 10, 10), workout: arms),
  LoggedWorkout(dateTime: DateTime(2024, 1, 5, 10, 10), workout: shoulders),
  LoggedWorkout(dateTime: DateTime(2024, 1, 6, 10, 10), workout: legs),
  LoggedWorkout(dateTime: DateTime(2024, 1, 7, 10, 10), workout: rest),
  LoggedWorkout(dateTime: DateTime(2024, 1, 8, 10, 10), workout: back),
  LoggedWorkout(dateTime: DateTime(2024, 1, 9, 10, 10), workout: arms),
  LoggedWorkout(dateTime: DateTime(2024, 1, 10, 10, 10), workout: shoulders),
  LoggedWorkout(dateTime: DateTime(2024, 1, 11, 10, 10), workout: rest),
  LoggedWorkout(dateTime: DateTime(2024, 1, 12, 10, 10), workout: chest),
  LoggedWorkout(dateTime: DateTime(2024, 1, 13, 10, 10), workout: back),
  LoggedWorkout(dateTime: DateTime(2024, 1, 14, 10, 10), workout: rest),
  LoggedWorkout(dateTime: DateTime(2024, 1, 15, 10, 10), workout: shoulders),
  LoggedWorkout(dateTime: DateTime(2024, 1, 16, 10, 10), workout: legs),
  LoggedWorkout(dateTime: DateTime(2024, 1, 17, 10, 10), workout: chest),
  LoggedWorkout(dateTime: DateTime(2024, 1, 18, 10, 10), workout: back),
  LoggedWorkout(dateTime: DateTime(2024, 1, 19, 10, 10), workout: arms),
  LoggedWorkout(dateTime: DateTime(2024, 1, 20, 10, 10), workout: shoulders),
  LoggedWorkout(dateTime: DateTime(2024, 1, 21, 10, 10), workout: legs),
  LoggedWorkout(dateTime: DateTime(2024, 1, 22, 10, 10), workout: rest),
  LoggedWorkout(dateTime: DateTime(2024, 1, 23, 10, 10), workout: back),
  LoggedWorkout(dateTime: DateTime(2024, 1, 24, 10, 10), workout: rest),
  LoggedWorkout(dateTime: DateTime(2024, 1, 25, 10, 10), workout: shoulders),
  LoggedWorkout(dateTime: DateTime(2024, 1, 26, 10, 10), workout: rest),
  LoggedWorkout(dateTime: DateTime(2024, 1, 27, 10, 10), workout: chest),
  LoggedWorkout(dateTime: DateTime(2024, 1, 28, 10, 10), workout: back),
  LoggedWorkout(dateTime: DateTime(2024, 1, 29, 10, 10), workout: arms),
  LoggedWorkout(dateTime: DateTime(2024, 1, 30, 10, 10), workout: shoulders),
];