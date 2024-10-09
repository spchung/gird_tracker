import 'package:flutter/material.dart';

class TabNavigator extends ChangeNotifier{
  final index = ValueNotifier<int>(0);

  void setIndex(int newIndex){
    index.value = newIndex;
    notifyListeners();
  }
}