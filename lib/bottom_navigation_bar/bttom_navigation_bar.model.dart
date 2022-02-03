
import 'package:flutter/material.dart';

class BottomNavigationBarModel extends ChangeNotifier {

  String? name;
  String? email;
  String? description;

  int _currentIndex = 0;
  get currentIndex => _currentIndex;

  void onTabTapped(int index) async {
    _currentIndex = index;

    notifyListeners();

  }
}