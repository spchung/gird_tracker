import 'package:get_it/get_it.dart';
import 'package:lets_git_it/service/app.dart';
import 'package:lets_git_it/service/tab_navigator.dart';
import 'package:lets_git_it/service/logged_workout.dart';

final sl = GetIt.instance;

void locatorSetUp() {
  sl.registerSingleton<AppModel>(AppModel());
  sl.registerSingleton<TabNavigator>(TabNavigator());
  sl.registerSingleton<LoggedWorkoutService>(LoggedWorkoutService());
}