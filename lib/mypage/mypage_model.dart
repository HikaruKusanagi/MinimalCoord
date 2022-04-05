import 'package:flutter/material.dart';

class MyPageModel extends ChangeNotifier {

  String? value;
  String? isSelectedItem = '150';
  String? isSelectedItem2 = '男性';

  void isSelectedItem3(value) {
    isSelectedItem = value;
    notifyListeners();
  }

  void isSelectedItem4(value) {
    isSelectedItem2 = value;
    notifyListeners();
  }
}


