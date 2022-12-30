import 'package:flutter/material.dart';

class InputNotifier extends ChangeNotifier {
  final List<bool> selectedFruits = <bool>[false, false];
  final List<bool> privateOrPublic = <bool>[true, false];

  // TODO: before sending, transform to UTC
  DateTime? startDateTime;
  DateTime? endDateTime;

  void resetEndDateTime() {
    endDateTime = null;
    notifyListeners();
  }

  List<Image> loadedImages = [];

  set selectedFruits(index) {
    for (int i = 0; i < selectedFruits.length; i++) {
      selectedFruits[i] = i == index;
    }
    notifyListeners();
  }

  set privateOrPublic(index) {
    for (int i = 0; i < privateOrPublic.length; i++) {
      privateOrPublic[i] = i == index;
    }
    notifyListeners();
  }

  set addImage(Image image) {
    loadedImages.add(image);
    notifyListeners();
  }
}
