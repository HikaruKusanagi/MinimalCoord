import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minimal_coord/accessories_page/accessories_page.dart';
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


  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider<PostUserDetailModel>(
      create: (_) => PostUserDetailModel()..fechCoordinateList()..blockList(coordinate.uid),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Column(
            children: [
              Text('Coordinate', style: GoogleFonts.yuseiMagic(
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
              Consumer<PostUserDetailModel>(
                  builder: (context, model, child) {
                    final List<Coordinate>? coordinate = model.coordinate;
                    if (coordinate == null) {
                      return Center(child: const CircularProgressIndicator(
                        color: Colors.black,
                      ));
                    }
                    (coordinate) =>
                        IconButton(
                            icon: Icon(Icons.person_off),
                            color: Colors.white,
                            onPressed: () async {
                              final userId = coordinate.uid;
                              print('userId; $userId');
                              await blockUserDialog(
                                  context, coordinate, model);
                            }
                            );
                    return Column(
                      children: [
                        IconButton(
                            icon: Icon(Icons.person_off),
                            color: Colors.white,
                            onPressed: () async {
                              final userId = coordinate;
                              print('userId; $userId');
                              await blockUserDialog(
                                  context, coordinate, model);
                            }
                            ),
                      ],
                    );
                  }),
            ]),
        body: SingleChildScrollView(
                  child: Column(
                      children: [
                        SizedBox(height: 30),
                        GestureDetector(
                          child: SizedBox(
                            height: 300,
                            width: 300,
                            child: Container(
                              decoration: BoxDecoration(color: Colors.grey,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          WholeBodyPage(
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
                        SizedBox(height: 20),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Column(
                              children: [
                                Row(
                                    children: [
                                      SizedBox(width: 10),
                                      Column(
                                        children: [
                                          Text('Tops',
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
                                              height: 100,
                                              width: 100,
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          TopsPage(
                                                            coordinate.tops,
                                                            coordinate.imgTopsURL,
                                                          ),
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey,
                                                    borderRadius: BorderRadius
                                                        .circular(10),
                                                  ),
                                                  child: Center(
                                                    child: Image.network(coordinate.imgTopsURL!),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(coordinate.tops, style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          ),
                                          SizedBox(height: 10),
                                          Column(
                                            children: [
                                              Text('Shoes',
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
                                                  height: 100,
                                                  width: 100,
                                                  child: InkWell(
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              ShoesPage(
                                                                coordinate.shoes,
                                                                coordinate.imgShoesURL,
                                                              ),
                                                        ),
                                                      );
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.grey,
                                                        borderRadius: BorderRadius
                                                            .circular(10),
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
                                                coordinate.shoes, style: const TextStyle(
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
                                      const SizedBox(width: 10),
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
                                              height: 100,
                                              width: 100,
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          BottmosPage(
                                                            coordinate.bottoms,
                                                            coordinate.imgBottomsURL,
                                                          ),
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey,
                                                    borderRadius: BorderRadius
                                                        .circular(10),
                                                  ),
                                                  child: Center(
                                                    child: Image.network(
                                                        coordinate.imgBottomsURL!),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(coordinate.bottoms, style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          ),
                                          const SizedBox(height: 10),
                                          Column(
                                            children: [
                                              Text('Accessories',
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
                                                  height: 100,
                                                  width: 100,
                                                  child: InkWell(
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              AccessoriesPage(
                                                                coordinate.accessories,
                                                                coordinate.imgAccessoriesURL,
                                                              ),
                                                        ),
                                                      );
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.grey,
                                                        borderRadius: BorderRadius
                                                            .circular(10),
                                                      ),
                                                      child: Center(
                                                        child:
                                                            //画像が入っていたら
                                                              Image.network(coordinate.imgAccessoriesURL!)
                                                            //   SizedBox(
                                                            //       height: 100,
                                                            //       width: 100,
                                                            //       child: Icon(Icons.add_a_photo,color: Colors.white)
                                                            //   ),

                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              Text(
                                                coordinate.accessories,
                                                style: const TextStyle(
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
                                      SizedBox(width: 10),
                                      Column(
                                        children: [
                                          Text('Outer',
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
                                              height: 100,
                                              width: 100,
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          OuterPage(
                                                            coordinate.outer,
                                                            coordinate.imgOuterURL,
                                                          ),
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey,
                                                    borderRadius: BorderRadius
                                                        .circular(10),
                                                  ),
                                                  child: Center(
                                                    child: Image.network(
                                                        coordinate.imgOuterURL!),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(coordinate.outer, style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          ),
                                          SizedBox(height: 10),
                                          Column(
                                            children: [
                                              Text('',
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
                                                  height: 100,
                                                  width: 100,
                                                ),
                                              ),
                                              SizedBox(height: 30),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                ),
                              ]),
                        ),
                      ]
                  ),
          ),
      ),
    );
  }

  Future blockUserDialog(
      BuildContext context,
      Coordinate,
      PostUserDetailModel model,) {
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