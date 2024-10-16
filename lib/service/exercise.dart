import 'package:lets_git_it/model/exercise.dart';
import 'package:lets_git_it/service/db.dart';
import 'package:lets_git_it/locator.dart';

class ExerciseService {
  
  Future<List<Exercise>> fetchExercises() async {
    var db = await sl.get<DatabaseHelper>().database;
    var res = await db.query('exercises');
    return res.map((e) => Exercise.fromMap(e)).toList();
  }

  Future<List<Exercise>> fetchExercisesByGroupId(String workoutGroupId) async {
    var db = await sl.get<DatabaseHelper>().database;
    var res = await db.query('exercises', where: 'workout_group_id = ?', whereArgs: [workoutGroupId]);
    return res.map((e) => Exercise.fromMap(e)).toList();
  }

  Future<void> addExercise(Exercise exercise) async {
    var db = await sl.get<DatabaseHelper>().database;
    await db.insert('exercises', exercise.toMap());
  }
}