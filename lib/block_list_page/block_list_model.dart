import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BlockListModel extends ChangeNotifier {
  List<String>? blockIds;

  Future<void> blockList(uid) async {
    final QuerySnapshot snapshot =
    await FirebaseFirestore.instance.collection('blocks')
        .where('blockUserId', isNotEqualTo: uid) // 〜と等しくない
        .get();

    final List<String>? blockIds = snapshot.docs.map((
        DocumentSnapshot document) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;

      final String blockUserId = data['blockUserId'];
      return (
          blockUserId
      );
    }).toList();

    this.blockIds = blockIds;
    notifyListeners();
  }

  Future<void> delete(uid) async {
    return FirebaseFirestore.instance.collection('blocks').doc(uid).delete();
  }
}