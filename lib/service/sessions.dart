import 'package:flutter/material.dart';
import 'package:lets_git_it/model/session.dart';
import 'package:lets_git_it/service/db.dart';
import 'package:lets_git_it/locator.dart';

class SessionsService extends ChangeNotifier {
  final _data = ValueNotifier<List<Session>>([]);

  List<Session> get data => _data.value;

  Future<List<Session>> fetchLoggedWorkouts() async {
    // await Future.delayed(const Duration(seconds: 1));
    // return tempData;
    var db = await sl.get<DatabaseHelper>().database;
    var res = await db.rawQuery('''
      SELECT sessions.id, sessions.dateTime, sessions.workout_group_id, workout_groups.name
      FROM sessions
      JOIN workout_groups ON sessions.workout_group_id = workout_groups.id
    ''');
    _data.value = res.map((e) => Session.fromMap(e)).toList();
    return _data.value;
  }

  void addLoggedWorkout(Session session) async {
    var db = await sl.get<DatabaseHelper>().database;
    db.insert('sessions', session.toMap());
    _data.value = [..._data.value, session];
    notifyListeners();
  }

  Future<Session> getData(int id) async {
    var db = await sl.get<DatabaseHelper>().database;
    var res = await db.rawQuery('''
      SELECT sessions.id, sessions.dateTime, sessions.workout_group_id, workout_groups.name
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