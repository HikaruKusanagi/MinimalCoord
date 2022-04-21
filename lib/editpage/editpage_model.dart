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
  String? height = '150';
  String? sex = 'MEN';

  void setName(String name) {
    this.name = name;
    notifyListeners();
  }

  bool isUpdated() {
    return name != null;
  }

  void Height(value) {
    height = value;
    notifyListeners();
  }

  void Sex(value) {
    sex = value;
    notifyListeners();
  }

  Future userUpdate() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance.collection('users').doc(uid).update({
      'name': name,
      'sex': sex,
      'height': height,
    });
  }
}
