import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:minimal_coord/domain/block.dart';
import 'package:minimal_coord/domain/coordinate.dart';
import 'dart:io';

class CoordinateListModel extends ChangeNotifier {
  List<Coordinate>? coordinate;
  List<Block>? blockIds;
  String? uid;
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


  //Firebaseと繋ぐ際はFutureを付ける
  Future<void> fechCoordinateList() async {
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



  Future<void> blockUser(uid) async {
    FirebaseFirestore.instance.collection('blocks')
        .doc().set(
      {
        'blockUserId' : uid,
      }
    );
    notifyListeners();
  }

  Future<void> blockList() async {
    final QuerySnapshot snapshot =
    await FirebaseFirestore.instance.collection('blocks').get();

    final List<Block> blockIds = snapshot.docs.map((
        DocumentSnapshot document) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;

      final String blockUserId = data['blockUserId'];
      return Block(
        blockUserId,
      );
    }).toList();

    this.blockIds = blockIds;
    notifyListeners();
  }
}