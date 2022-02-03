import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:minimal_coord/domain/coordinate.dart';

class ConfigurationModel extends ChangeNotifier {
  final Coordinate coordinate;

  ConfigurationModel(this.coordinate) {
    heightController.text = coordinate.height;
  }

  final heightController = TextEditingController();

  String? height;
  bool isLoading = false;


  void setHeight(String height) {
    this.height = height;
    notifyListeners();
  }

  bool isUpdated() {
    return height != null && height != null;
  }

  Future update() async {
    this.height = heightController.text;

    // firestoreに追加
    await FirebaseFirestore.instance.collection('coordinate').doc(coordinate.id).update({
      'height': height,
    });
  }
}

