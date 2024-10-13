import 'package:lets_git_it/model/workout_group.dart';
import 'package:lets_git_it/service/db.dart';
import 'package:lets_git_it/locator.dart';

class WorkoutGroupService {
  List<WorkoutGroup> _workoutGroups = [];

  List<WorkoutGroup> get workoutGroups => _workoutGroups;

  Future<List<WorkoutGroup>> fetchWorkoutGroups() async {
    var db = await sl.get<DatabaseHelper>().database;
    var res = await db.query('workout_groups');
    _workoutGroups = res.map((e) => WorkoutGroup.fromMap(e)).toList();
    return _workoutGroups;
  }
}