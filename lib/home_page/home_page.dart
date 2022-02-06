import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:minimal_coord/bottom_navigation_bar/bttom_navigation_bar.dart';
import 'package:minimal_coord/google_signin_page/google_signin_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
    body: StreamBuilder(
      //ログイン/ログアウトの度にbuilderの中身が読み込まれる。
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          //ログイン情報を持っている場合はUserPageに遷移
          return BottomNavigationBarPage();
        } else if (snapshot.hasError) {
          //適切でない文字が入力された場合
          return Center(child: Text('問題が発生しました'));
        } else {
          //持っていない場合はGoogleSigInPageに遷移
          return GoogleSigInPage();
        }
      },
    ),
  );
}