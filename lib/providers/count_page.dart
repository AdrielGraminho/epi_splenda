import 'package:flutter/material.dart';

class CountPage extends ChangeNotifier {
  int _counter = 0;

  int get counter => _counter;

  void incrementCounter(int page) {
    _counter = page;
    notifyListeners();
  }
}
