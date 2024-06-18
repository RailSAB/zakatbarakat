import 'package:flutter/material.dart';

class WorkoutProvider extends ChangeNotifier {
  int _number = 0;
  int get number => _number;
  set number(int value) {
    _number = value;
    notifyListeners();
  }
  
}