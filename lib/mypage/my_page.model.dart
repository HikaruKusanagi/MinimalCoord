import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyPageModel extends ChangeNotifier {

  bool isLoading = false;
  String? name;
  String? photoURL;
  String? email;
  String? value;
  String? isSelectedItem;
  String? isSelectedItem2;

  void startLoading() {
    isLoading = true;
    notifyListeners();
  }

  void endLoading() {
    isLoading = false;
    notifyListeners();
  }

  void fetchUser() async {
    final user = FirebaseAuth.instance.currentUser;
    this.email = user?.email;

    final uid = FirebaseAuth.instance.currentUser!.uid;
    final snapshot =
    await FirebaseFirestore.instance.collection('users').doc(uid).get();
    final data = snapshot.data();
    this.name = data?['name'];
    this.photoURL = data?['photoURL'];
    this.isSelectedItem = data?['isSelectedItem'];
    this.isSelectedItem2 = data?['isSelectedItem2'];
    notifyListeners();
  }

  void isSelectedItem3(value) {
    isSelectedItem = value;
    notifyListeners();
  }

  void isSelectedItem4(value) {
    isSelectedItem2 = value;
    notifyListeners();
  }
}