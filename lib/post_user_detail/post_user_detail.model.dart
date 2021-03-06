import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:minimal_coord/domain/coordinate.dart';

class PostUserDetailModel extends ChangeNotifier {
  List<Coordinate>? coordinate;
  List<String>? blockIds;
  String? name;
  String? uid;
  String? email;
  String? sex;
  String? height;

  Future<void> fechCoordinateList() async {
    final QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('coordinate').get();

    final List<Coordinate> coordinate =
        snapshot.docs.map((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;

      final String uid = data['uid'];
      final String id = document.id;
      final String height = data['height'];
      final String sex = data['sex'];
      final String tops = data['tops'];
      final String bottoms = data['bottoms'];
      final String outer = data['outer'];
      final String shoes = data['shoes'];

      final String? imgURL = data['imgURL'];
      final String? imgTopsURL = data['imgTopsURL'];
      final String? imgBottomsURL = data['imgBottomsURL'];
      final String? imgOuterURL = data['imgOuterURL'];
      final String? imgShoesURL = data['imgShoesURL'];

      return Coordinate(
        uid,
        id,
        sex,
        height,
        tops,
        bottoms,
        outer,
        shoes,
        imgURL,
        imgTopsURL,
        imgBottomsURL,
        imgOuterURL,
        imgShoesURL,
      );
    }).toList();

    this.coordinate = coordinate;
    notifyListeners();
  }

  Future<void> blockUser(userId) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance.collection('blocks').doc(uid).set({
      'blockUserId': userId,
    });
    notifyListeners();
  }

  Future<void> blockList(uid) async {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('blocks')
        .where('blockUserId', isNotEqualTo: uid) // ?????????????????????
        .get();

    final List<String>? blockIds =
        snapshot.docs.map((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;

      final String blockUserId = data['blockUserId'];
      return (blockUserId);
    }).toList();

    this.blockIds = blockIds;
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
    this.uid = data?['uid'];
    notifyListeners();
  }
}
