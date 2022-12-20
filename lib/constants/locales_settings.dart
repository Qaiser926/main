import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const Iterable<Locale> supportedLocales = [Locale('de', ''), Locale('en', '')];

class LocaleProvider with ChangeNotifier {
  Locale? _locale;

  Locale? get locale => _locale;

  void setLocale(Locale loc) {
    if (!supportedLocales.contains(loc)) return;
    _locale = loc;
    notifyListeners();
  }

  void clearLocale() {
    _locale = null;
    notifyListeners();
  }

  Locale? get getLocale => _locale;
}
