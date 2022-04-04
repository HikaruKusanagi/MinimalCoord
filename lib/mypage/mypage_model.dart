import 'package:flutter/material.dart';

class MyPageModel extends ChangeNotifier {

  String? value;

  void isSelectedItem() {
    this.value = value;
    notifyListeners();
  }
}