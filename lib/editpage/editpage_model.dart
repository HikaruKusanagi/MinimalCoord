import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditPageModel extends ChangeNotifier {
  EditPageModel(this.name) {
    nameController.text = name!;
  }

  final nameController = TextEditingController();

  String? name;
  String? email;
  String? value;
  String? isSelectedItem = '150';
  String? isSelectedItem2 = 'MEN';


  void setName(String name) {
    this.name = name;
    notifyListeners();
  }

  bool isUpdated() {
    return name != null;
  }

  void isSelectedItem3(value) {
    isSelectedItem = value;
    notifyListeners();
  }


  void isSelectedItem4(value) {
    isSelectedItem2 = value;
    notifyListeners();
  }


  Future update() async {
    String? photoURL;

    this.name = nameController.text;
    final uid = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance.collection('users').doc(uid).update({
      'name': name,
      'isSelectedItem': isSelectedItem,
      'isSelectedItem2': isSelectedItem2,
    });
  }
}




