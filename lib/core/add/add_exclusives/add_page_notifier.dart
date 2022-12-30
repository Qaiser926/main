import 'package:flutter/material.dart';

class AddPageNotifier extends ChangeNotifier {
  int _currentPage = 0;

  AddPageNotifier(int firstPage) : _currentPage = firstPage;

  int get currentPage => _currentPage;

  set currentPage(int currentPage) {
    _currentPage = currentPage;
    notifyListeners();
  }
}
