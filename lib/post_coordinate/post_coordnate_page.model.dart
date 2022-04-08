import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class PostCoordinatePageModel extends ChangeNotifier {

  String? tops;
  String? bottoms;
  String? outer;
  String? shoes;

  String? imgURL;
  String? imgTopsURL;
  String? imgBottomsURL;
  String? imgOuterURL;
  String? imgShoesURL;

  File? imageFile;
  File? topsImageFile;
  File? bottomsImageFile;
  File? outerImageFile;
  File? shoesImageFile;

  final picker = ImagePicker();
  bool isLoading = false;

  void startLoading() {
    isLoading = true;
    notifyListeners();
  }

  void endLoading() {
    isLoading = false;
    notifyListeners();
  }


  Future addCoordinate() async {

    if (imageFile == null || imageFile == "") {
      throw '全身画像が入力されていません';
    }

    if (topsImageFile == null || topsImageFile == "") {
      throw 'Tops画像が入力されていません';
    }

    if (bottomsImageFile == null || bottomsImageFile == "") {
      throw 'Bottomsが入力されていません';
    }

    if (outerImageFile == null || outerImageFile == "") {
      throw 'Outerが入力されていません';
    }

    if (shoesImageFile == null || shoesImageFile == "") {
      throw 'Shoesが入力されていません';
    }


    final doc = FirebaseFirestore.instance.collection('coordinate').doc();

    if (imageFile != null) {
      // storageにアップロード
      final task = await FirebaseStorage.instance
          .ref('coordinate/${doc.id}')
          .putFile(imageFile!);
      imgURL = await task.ref.getDownloadURL();
    }

    if (topsImageFile != null) {

      final task = await FirebaseStorage.instance
          .ref('coordinate/${doc.id}_tops')
          .putFile(topsImageFile!);
      imgTopsURL = await task.ref.getDownloadURL();
    }

    if (bottomsImageFile != null) {
      // storageにアップロード
      final task = await FirebaseStorage.instance
          .ref('coordinate/${doc.id}_bottoms')
          .putFile(bottomsImageFile!);
      imgBottomsURL = await task.ref.getDownloadURL();
    }

    if (outerImageFile != null) {

      final task = await FirebaseStorage.instance
          .ref('coordinate/${doc.id}_outer')
          .putFile(outerImageFile!);
      imgOuterURL = await task.ref.getDownloadURL();
    }

    if (shoesImageFile != null) {

      final task = await FirebaseStorage.instance
          .ref('coordinate/${doc.id}_shoes')
          .putFile(shoesImageFile!);
      imgShoesURL = await task.ref.getDownloadURL();
    }


    final uid = FirebaseAuth.instance.currentUser!.uid;

    // Firestoreに追加
    return FirebaseFirestore.instance.collection('coordinate')
        .doc().set(
        {
          'uid': uid,

          'tops': tops,
          'bottoms': bottoms,
          'outer': outer,
          'shoes': shoes,

          'imgURL': imgURL,
          'imgTopsURL': imgTopsURL,
          'imgBottomsURL' :imgBottomsURL,
          'imgOuterURL' : imgOuterURL,
          'imgShoesURL' : imgShoesURL,
    });
  }

  Future pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      notifyListeners();
    }
  }

  Future topsImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      topsImageFile = File(pickedFile.path);
      notifyListeners();
    }
  }

  Future bottomsImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      bottomsImageFile = File(pickedFile.path);
      notifyListeners();
    }
  }

  Future outerImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      outerImageFile = File(pickedFile.path);
      notifyListeners();
    }
  }

  Future shoesImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      shoesImageFile = File(pickedFile.path);
      notifyListeners();
    }
  }
}