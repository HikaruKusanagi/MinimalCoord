import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditPageModel extends ChangeNotifier {

  String? email;
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

    void fetchUser() {
    final user = FirebaseAuth.instance.currentUser;
    this.email = user?.email;
    }
  }
}


