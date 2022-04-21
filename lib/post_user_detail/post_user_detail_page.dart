import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minimal_coord/bottmos_page/bottmos_page.dart';
import 'package:minimal_coord/domain/coordinate.dart';
import 'package:minimal_coord/outer_page/outer_page.dart';
import 'package:minimal_coord/post_user_detail/post_user_detail.model.dart';
import 'package:minimal_coord/shoes_page/shoes_page.dart';
import 'package:minimal_coord/tops_page/tops_page.dart';
import 'package:minimal_coord/wholebody/whole_body_page.dart';
import 'package:provider/provider.dart';

class PostUserDetailPage extends StatelessWidget {
  PostUserDetailPage(this.coordinate);

  final Coordinate coordinate;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PostUserDetailModel>(
      create: (_) => PostUserDetailModel()
        ..fechCoordinateList()
        ..blockList(coordinate.uid)
        ..fetchUser(),
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.black,
            title: Column(children: [
              Text(
                'Coordinate',
                style: GoogleFonts.yuseiMagic(
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ]),
            centerTitle: false,
            actions: [
              Consumer<PostUserDetailModel>(builder: (context, model, child) {
                final List<Coordinate>? coordinate = model.coordinate;
                if (coordinate == null) {
                  return Center(
                      child: const CircularProgressIndicator(
                    color: Colors.black,
                  ));
                }
                (coordinate) => IconButton(
                    icon: Icon(Icons.person_off),
                    color: Colors.white,
                    onPressed: () async {
                      final userId = coordinate.uid;
                      print('userId; $userId');
                      await blockUserDialog(context, coordinate, model);
                    });
                return Column(
                  children: [
                    IconButton(
                        icon: Icon(Icons.person_off),
                        color: Colors.white,
                        onPressed: () async {
                          final userId = coordinate;
                          print('userId; $userId');
                          await blockUserDialog(context, coordinate, model);
                        }),
                  ],
                );
              }),
            ]),
        body: Consumer<PostUserDetailModel>(builder: (context, model, child) {
          return SingleChildScrollView(
            child: Column(children: [
              SizedBox(height: 30),
              GestureDetector(
                child: SizedBox(
                  height: 330,
                  width: 330,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WholeBodyPage(
                              coordinate.imgURL,
                            ),
                          ),
                        );
                      },
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Image.network(coordinate.imgURL!),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              '',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            SizedBox(width: 10),
                            Text(
                              coordinate.sex,
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            Container(
                              height: 20,
                              width: 10,
                              child: VerticalDivider(
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              coordinate.height + 'cm',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(width: 40),
                  ],
                ),
              ),
              SizedBox(height: 20),
              SingleChildScrollView(
                child: Column(children: [
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Column(
                      children: [
                        Text(
                          'Tops',
                          style: GoogleFonts.yuseiMagic(
                            textStyle: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        GestureDetector(
                          child: SizedBox(
                            height: 150,
                            width: 150,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TopsPage(
                                      coordinate.tops,
                                      coordinate.imgTopsURL,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Image.network(coordinate.imgTopsURL!),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          coordinate.tops,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Column(
                          children: [
                            Text(
                              'Shoes',
                              style: GoogleFonts.yuseiMagic(
                                textStyle: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            GestureDetector(
                              child: SizedBox(
                                height: 150,
                                width: 150,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ShoesPage(
                                          coordinate.shoes,
                                          coordinate.imgShoesURL,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Image.network(
                                          coordinate.imgShoesURL!),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              coordinate.shoes,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(width: 30),
                    Column(
                      children: [
                        Text(
                          'Bottmos',
                          style: GoogleFonts.yuseiMagic(
                            textStyle: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        GestureDetector(
                          child: SizedBox(
                            height: 150,
                            width: 150,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BottmosPage(
                                      coordinate.bottoms,
                                      coordinate.imgBottomsURL,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child:
                                      Image.network(coordinate.imgBottomsURL!),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          coordinate.bottoms,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(width: 10),
                        Column(
                          children: [
                            Text(
                              'Outer',
                              style: GoogleFonts.yuseiMagic(
                                textStyle: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            GestureDetector(
                              child: SizedBox(
                                height: 150,
                                width: 150,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => OuterPage(
                                          coordinate.outer,
                                          coordinate.imgOuterURL,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Image.network(
                                          coordinate.imgOuterURL!),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              coordinate.outer,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      ],
                    ),
                  ]),
                ]),
              )
            ]),
          );
        }),
      ),
    );
  }

  Future blockUserDialog(
    BuildContext context,
    Coordinate,
    PostUserDetailModel model,
  ) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          title: Text("確認"),
          content: Text('投稿者をブロックしますか？'),
          actions: [
            TextButton(
              child: Text("いいえ"),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text("はい"),
              onPressed: () async {
                final userId = coordinate.uid;
                print('userId; $userId');
                await model.blockUser(userId);
                Navigator.of(context).popUntil((route) => route.isFirst);
                final snackBar = SnackBar(
                  backgroundColor: Colors.black,
                  content: Text('投稿者をブロックしました'),
                );
                model.fechCoordinateList();
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
            ),
          ],
        );
      },
    );
  }
}
