// write a test class
import 'package:flutter/material.dart';
// import 'package:watch_it/watch_it.dart';

// TEMPORARY DATA
class AppModel extends ChangeNotifier {
  final counter = ValueNotifier<int>(0);

  void incrementCounter() {
    counter.value++;
    notifyListeners();
  }

  int getCounter() {
    return counter.value;
  }

  void resetCounter() {
    counter.value = 0;
    notifyListeners();
  }

  void decrementCounter() {
    counter.value--;
    notifyListeners();
  }
}