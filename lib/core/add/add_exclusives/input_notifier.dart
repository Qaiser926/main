import 'package:flutter/material.dart';

class InputNotifier extends ChangeNotifier {
  final List<bool> selectedFruits = <bool>[true, false];
  final List<bool> privateOrPublic = <bool>[true, false];

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
