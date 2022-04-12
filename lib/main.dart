import 'package:flutter/material.dart';
import 'package:minimal_coord/home_page/home_page.dart';
import 'package:minimal_coord/signin_page/singin_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
      MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
    create: (context) => SigInModel(),
    child:  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    ),
  );
}