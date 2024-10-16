import 'package:flutter/material.dart';
import 'package:lets_git_it/model/session.dart';
import 'package:lets_git_it/service/db.dart';
import 'package:lets_git_it/locator.dart';

class SessionsService extends ChangeNotifier {
  final _sessions = ValueNotifier<List<Session>>([]);

  ValueNotifier<List<Session>> get sessions => _sessions;

  Future<List<Session>> fetchLoggedWorkouts() async {
    var db = await sl.get<DatabaseHelper>().database;
    var res = await db.rawQuery('''
      SELECT sessions.id, sessions.dateTime, sessions.workout_group_id, workout_groups.name
      FROM sessions
      JOIN workout_groups ON sessions.workout_group_id = workout_groups.id
    ''');
    _sessions.value = res.map((e) => Session.fromMap(e)).toList();
    return _sessions.value;
  }

  void addLoggedWorkout(Session session) async {
    var db = await sl.get<DatabaseHelper>().database;
    try {
      db.insert('sessions', session.toMap());
    }
    catch (e) {
      print(e);
    }
    _sessions.value = [..._sessions.value, session];
    notifyListeners();
  }

  Future<Session> getData(int id) async {
    var db = await sl.get<DatabaseHelper>().database;
    var res = await db.rawQuery('''
      SELECT sessions.id, sessions.dateTime, sessions.workout_group_id, workout_groups.name, sessions.exercises
      FROM sessions
      JOIN workout_groups ON sessions.workout_group_id = workout_groups.id
      WHERE sessions.id = $id
    ''');
    return Session.fromMap(res.first);
  }

  void execute(String sql) async {
    var db = await sl.get<DatabaseHelper>().database;
    var res  = await db.rawQuery(sql);
    print(res);
  }
}