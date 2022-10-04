import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  int _currentIndex = 0;
  bool _isMute = true;
  void onTabTapped(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  int get currentTap => _currentIndex;
  bool get isMute => _isMute;

  void toggleMuteButton() {
    _isMute = !_isMute;
    notifyListeners();
  }
}
