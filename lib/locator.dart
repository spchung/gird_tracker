import 'package:get_it/get_it.dart';
import 'package:lets_git_it/services/app.dart';

final sl = GetIt.instance;

void locatorSetUp() {
  sl.registerSingleton<AppModel>(AppModel());
}