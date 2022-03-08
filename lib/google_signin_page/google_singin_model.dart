import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class GoogleSigInModel extends ChangeNotifier {

  String? Tops = '';
  String? Bottoms = '';
  String? Outer = '';
  String? Shoes = '';
  String? Accessorie = '';
  String? email;
  String? AppleLoginName;

  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  // Future googleLogin() async {
  //
  //   try {
  //     final googleUser = await googleSignIn.signIn();
  //     if (googleUser == null) return;
  //     _user = googleUser;
  //     final googleAuth = await googleUser.authentication;
  //     // Google認証の部分
  //     final credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth.accessToken,
  //       idToken: googleAuth.idToken,
  //     );
  //
  //     //クレデンシャル情報を受け取り、Firebaseでログイン
  //     final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
  //
  //     //userの情報取り出す
  //     final user = userCredential.user;
  //
  //     if (user == null) {
  //       print('ログインに失敗している');
  //       return;
  //     }
  //
  //     //uid取得
  //     final uid = user!.uid;
  //
  //     //Firestoreに追加
  //     final doc = FirebaseFirestore.instance.collection('users').doc(uid);
  //     await doc.set({
  //       'name': user.displayName,
  //       'email': user.email,
  //       'uid': uid,
  //     });
  //
  //     // Google認証を通過した後、Firebase側にログイン
  //     await FirebaseAuth.instance.signInWithCredential(credential);
  //   } catch (e) {
  //     print(e.toString());
  //   }
  //   notifyListeners();
  // }

  Future<UserCredential> signInWithGoogle() async {
    //認証フローをトリガーします
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    //リクエストから認証の詳細を取得します
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    //新しいクレデンシャルを作成します
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // 上記の公式ドキュメントの例の最終行を適当な変数で受ける。
    // エディタでカーソルを合わせると `UserCredential` 型だとわかる。
    final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);


    // userCerendetial.user は nullable なのでチェックする。だめなら return
    // null（= 未ログイン）なら何らかの理由で userCredential の生成に失敗している
    final user = userCredential.user;
    final uid = user!.uid;


    //userがnullだったたら、「ログインに失敗している」
    if (user == null) {
      print('ログインに失敗している');
    }

    //Firestoreに追加
    final doc = FirebaseFirestore.instance.collection('users').doc(uid);
    await doc.set({
      'googleLoginName': user.displayName,
      'email': user.email,
      'uid': uid,
    });
    //サインインしたら、UserCredentialを返します
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<UserCredential> appleLogin() async {

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
    final uid = user!.uid;

    if (user == null) {
      print('ログインに失敗している');
    }


    //Firestoreに追加
    final doc = FirebaseFirestore.instance.collection('users').doc(uid);
    await doc.set({
      'AppleLoginName': user.displayName,
      'id': user.email,
      'uid': uid,
    });
    return await FirebaseAuth.instance.signInWithCredential(oauthCredential);
  }


  Future logout() async {
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }
}

