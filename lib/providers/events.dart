import 'package:flutter/material.dart';

class EventsData with ChangeNotifier {
  void updateCarousel(int currentIndex, int index) {
    currentIndex = index;
    notifyListeners();
  }
}
