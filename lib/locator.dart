import 'package:get_it/get_it.dart';
import 'package:lets_git_it/service/app.dart';
import 'package:lets_git_it/service/db.dart';
import 'package:lets_git_it/service/tab_navigator.dart';
import 'package:lets_git_it/service/sessions.dart';
import 'package:lets_git_it/service/workout_group.dart';

final sl = GetIt.instance;

void locatorSetUp() {
  sl.registerSingleton<AppModel>(AppModel());
  sl.registerSingleton<TabNavigator>(TabNavigator());
  sl.registerSingleton<SessionsService>(SessionsService());
  sl.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());
  sl.registerSingleton<WorkoutGroupService>(WorkoutGroupService());
}