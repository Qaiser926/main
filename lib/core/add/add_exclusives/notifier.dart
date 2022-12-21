import 'package:flutter/material.dart';

class AddNotifier extends ChangeNotifier {
  int _currentPage = 0;

  AddNotifier(int firstPage) : _currentPage = firstPage;

  int get currentPage => _currentPage;

  set currentPage(int currentPage) {
    _currentPage = currentPage;
    notifyListeners();
  }
}
