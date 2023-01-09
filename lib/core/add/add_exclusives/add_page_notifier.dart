import 'package:flutter/material.dart';

class SwitchAddPageNotifier extends ChangeNotifier {
  int _currentPage = 0;

  SwitchAddPageNotifier(int firstPage) : _currentPage = firstPage;

  int get currentPage => _currentPage;

  set currentPage(int currentPage) {
    _currentPage = currentPage;
    notifyListeners();
  }
}
