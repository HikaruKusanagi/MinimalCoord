import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:minimal_coord/domain/coordinate.dart';
import 'dart:io';

class CoordinateListModel extends ChangeNotifier {

  final user = FirebaseAuth.instance.currentUser!;
  List<Coordinate>? coordinate;
  bool isVisible = false;

  String? height;
  String? tops;
  String? bottoms;
  String? outer;
  String? shoes;
  String? accessories;

  String? imgURL;
  String? imgTopsURL;
  String? imgBottomsURL;
  String? imgOuterURL;
  String? imgShoesURL;
  String? imgAccessoriesURL;

  File? imageFile;
  File? topsImageFile;
  File? bottomsImageFile;
  File? outerImageFile;
  File? shoesImageFile;
  File? accessoriesImageFile;

  void toggleShowText(){
    isVisible = !isVisible;
    notifyListeners();
  }

  void fechCoordinateList() async {
    final QuerySnapshot snapshot =
    await FirebaseFirestore.instance.collection('coordinate').get();

    final List<Coordinate> coordinate = snapshot.docs.map((
        DocumentSnapshot document) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;

      final String uid = data['uid'];
      final String id = document.id;
      final String height = data['height'];
      final String tops = data['tops'];
      final String bottoms = data['bottoms'];
      final String outer = data['outer'];
      final String shoes = data['shoes'];
      final String accessories = data['accessories'];

      final String? imgURL = data['imgURL'];
      final String? imgTopsURL = data['imgTopsURL'];
      final String? imgBottomsURL = data['imgBottomsURL'];
      final String? imgOuterURL = data['imgOuterURL'];
      final String? imgShoesURL = data['imgShoesURL'];
      final String? imgAccessoriesURL = data['imgAccessoriesURL'];
      return Coordinate(
        uid,
        id,
        height,
        tops,
        bottoms,
        outer,
        shoes,
        accessories,

        imgURL,
        imgTopsURL,
        imgBottomsURL,
        imgOuterURL,
        imgShoesURL,
        imgAccessoriesURL,
      );
    }).toList();

    this.coordinate = coordinate;
    notifyListeners();
  }

  Future blockUser(uid) async {

    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('blocks')
        .where('uid', isEqualTo: 'MmvE0YZ3VuXf0hzGhs2B2pOUSk42')
        .get();

    final List<Coordinate> coordinate = snapshot.docs.map((
        DocumentSnapshot document) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;

      final String uid = data['uid'];
      final String id = document.id;
      final String height = data['height'];
      final String tops = data['tops'];
      final String bottoms = data['bottoms'];
      final String outer = data['outer'];
      final String shoes = data['shoes'];
      final String accessories = data['accessories'];

      final String? imgURL = data['imgURL'];
      final String? imgTopsURL = data['imgTopsURL'];
      final String? imgBottomsURL = data['imgBottomsURL'];
      final String? imgOuterURL = data['imgOuterURL'];
      final String? imgShoesURL = data['imgShoesURL'];
      final String? imgAccessoriesURL = data['imgAccessoriesURL'];
      return Coordinate(
        uid,
        id,
        height,
        tops,
        bottoms,
        outer,
        shoes,
        accessories,

        imgURL,
        imgTopsURL,
        imgBottomsURL,
        imgOuterURL,
        imgShoesURL,
        imgAccessoriesURL,
      );
    }).toList();

    this.coordinate = coordinate;
    notifyListeners();

    return FirebaseFirestore.instance.collection('blocks')
        .doc(uid).set(
      {
        'name': user.displayName,
        'email': user.email,
        'uid' : uid,

        'height' : height,
        'tops': tops,
        'bottoms': bottoms,
        'outer': outer,
        'shoes': shoes,
        'accessories': accessories,

        'imgURL': imgURL,
        'imgTopsURL': imgTopsURL,
        'imgBottomsURL' :imgBottomsURL,
        'imgOuterURL' : imgOuterURL,
        'imgShoesURL' : imgShoesURL,
        'imgAccessoriesURL' : imgAccessoriesURL,
      }
    );
  }
}