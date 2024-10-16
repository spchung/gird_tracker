import 'package:flutter/material.dart';
import 'package:lets_git_it/locator.dart';
import 'package:lets_git_it/view/test.dart';
import 'package:watch_it/watch_it.dart';
import 'package:lets_git_it/view/home.dart';
import 'package:lets_git_it/service/tab_navigator.dart';
import 'package:lets_git_it/view/add_exercise_view.dart';

class HomeNavigator extends StatelessWidget with WatchItMixin {
  const HomeNavigator({super.key});

  static const  List<Widget> _widgetOptions = <Widget>[
    HomeView(),
    AddExerciseView(),
    VerticalStackScrollView(),
  ];

  @override
  Widget build(BuildContext context) {
    var index = watch(sl<TabNavigator>().index);
    return Scaffold(
      // use indexStack to keep page state in memory and switch between them
      body: IndexedStack(
        index: index.value,
        children: _widgetOptions,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        unselectedLabelStyle: const TextStyle(
          color: Colors.black,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        selectedLabelStyle: const TextStyle(
          color: Color.fromRGBO(252, 200, 14, 1),
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'School',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'business',
          ),
        ],
        onTap: (value) => sl<TabNavigator>().setIndex(value),
        currentIndex: index.value,
      ),
      
    );
  }
}