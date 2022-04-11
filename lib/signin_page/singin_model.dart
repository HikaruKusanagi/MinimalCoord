import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

final SigInProvider = ChangeNotifierProvider(
    create: (ref) => SigInModel(),
);

class SigInModel extends ChangeNotifier {

  String? email;
  String? AppleLoginName;

  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  Future googleLogin() async {

    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return;
      _user = googleUser;
      final googleAuth = await googleUser.authentication;
      // Google認証の部分
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      //クレデンシャル情報を受け取り、Firebaseでログイン
      final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

      //userの情報取り出す
      final user = userCredential.user;

      if (user == null) {
        print('ログインに失敗している');
        return;
      }

      //uid取得
      final uid = FirebaseAuth.instance.currentUser!.uid;

      //Firestoreに追加
      final doc = FirebaseFirestore.instance.collection('users').doc(uid);
      await doc.set({
        'GoogleLogin': '',
        'name': user.displayName,
        'email': user.email,
        'uid': uid,
      });

      // Google認証を通過した後、Firebase側にログイン
      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      print(e.toString());
    }
  }

  Future appleLogin() async {

    try {
      final rawNonce = generateNonce();

      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        rawNonce: rawNonce,
      );

      final userCredential = await FirebaseAuth.instance.signInWithCredential(oauthCredential);

      final user = userCredential.user;

      if (user == null) {
        print('ログインに失敗している');
        return;
      }

      final uid = FirebaseAuth.instance.currentUser!.uid;

      //Firestoreに追加
      final doc = FirebaseFirestore.instance.collection('users').doc(uid);
      await doc.set({
        'AppleLogin': '',
        'name': '',
        'email': '',
        'uid': uid,
        'isSelectedItem' : '',
        'isSelectedItem2' : '',
      });

      await FirebaseAuth.instance.signInWithCredential(oauthCredential);
    } catch (e) {
      print(e.toString());
    }
  }


  Future logout(context) async {
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
    Navigator.of(context).popUntil((route) => route.isFirst);
  }
}

