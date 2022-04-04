import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:minimal_coord/coordinate_list/coordinate_list_page.dart';
import 'package:minimal_coord/rule_page/rule_page.dart';
import 'package:minimal_coord/signin_page/signin_page.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) => Scaffold(
    body: StreamBuilder(
      //ログイン/ログアウトの度にbuilderの中身が読み込まれる。
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator(
            color: Colors.black,
          ));
        } else if (snapshot.hasData) {
          //ログイン情報を持っている場合はCoordinateListPageに遷移
          return CoordinateListPage();
        } else if (snapshot.hasError) {
          //適切でない文字が入力された場合
          return Center(child: Text('問題が発生しました'));
        } else {
          //持っていない場合はGoogleSigInPageに遷移
          return SigInPage();
        }
      },
    ),
  );
}