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
  String? password;
  String? displayName;

  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  Future googleLogin() async {

    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return;
      _user = googleUser;
      final googleAuth = await googleUser.authentication;
      // ログイン時にユーザーのuidが作成される
      // Google認証の部分
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      if (email != null && password != null) {
        // firebase authでユーザー作成
        final userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email!, password: password!);
        //SignIn時にuidを取得する
        final uid = FirebaseAuth.instance.currentUser!.uid;
        //uidが作成され、uidが取得される
        final user = userCredential.user;
        if (user != null) {
          final uid = user.uid;

          //Firestoreに追加
          final doc = FirebaseFirestore.instance.collection('users').doc(uid);
          await doc.set({
            'name': user.displayName,
            'email': user.email,
            'uid': uid,
          });
        }
      }
      // Google認証を通過した後、Firebase側にログイン
      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      print(e.toString());
    }

    notifyListeners();
  }

  Future appleLogin() async {

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

    await FirebaseAuth.instance.signInWithCredential(oauthCredential);
    print(appleCredential);
    notifyListeners();
  }


  Future logout() async {
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }
}

