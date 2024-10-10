import 'package:flutter/material.dart';
import 'package:lets_git_it/model/workout.dart';
import 'package:lets_git_it/view/temp_data.dart';

class LoggedWorkoutService extends ChangeNotifier {
  // String _id;

  Future<List<LoggedWorkout>> fetchLoggedWorkouts() async {
    await Future.delayed(const Duration(seconds: 1));
    
    return tempData;
  }
}