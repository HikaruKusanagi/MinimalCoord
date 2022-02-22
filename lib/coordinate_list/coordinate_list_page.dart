import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minimal_coord/coordinate_list/coordinate_list_model.dart';
import 'package:minimal_coord/domain/coordinate.dart';
import 'package:minimal_coord/google_signin_page/google_singin_model.dart';
import 'package:minimal_coord/post_coordinate/post_coordinate_page.dart';
import 'package:minimal_coord/post_user_detail/post_user_detail_page.dart';
import 'package:minimal_coord/report_page/report_page.dart';
import 'package:minimal_coord/rule_page/rule_page.dart';
import 'package:provider/provider.dart';

class CoordinateListPage extends StatelessWidget {

  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CoordinateListModel>(
      create: (_) => CoordinateListModel()..fechCoordinateList(),
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('TimeLine', style: GoogleFonts.yuseiMagic(
                  textStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ),
              ],
            ),
            centerTitle: false,
            actions: [
              IconButton(
                  icon: const Icon(Icons.info),
                  color: Colors.black,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RulePage()),
                    );
                  }),
              IconButton(
                  icon: const Icon(Icons.logout),
                  color: Colors.black,
                  onPressed: () {
                    final provider = Provider.of<GoogleSigInModel>(
                        context, listen: false);
                    provider.logout();
                  }),
            ]
        ),
        body: Center(
          child: Consumer<CoordinateListModel>(
              builder: (context, model, child) {
                final List<Coordinate>? coordinate = model.coordinate;
                if (coordinate == null) {
                  return const CircularProgressIndicator();
                }
                final List<Widget> widgets = coordinate
                    .map(
                      (coordinate) =>
                      Card(
                        color: Colors.white,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(width: 170),
                                ElevatedButton(
                                  child: Text('通報',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.black,
                                  ),
                                  onPressed: () =>
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ReportPage(
                                                  coordinate.imgURL!
                                              ),
                                        ),
                                      ),
                                ),
                                SizedBox(width: 10),
                                ElevatedButton(
                                  child: Text('ブロック',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.black,
                                  ),
                                  onPressed: () async =>
                                  await showConfirmDialog (context, coordinate, model),
                                ),
                              ],
                            ),
                            ListTile(
                                title: coordinate.imgURL != null
                                    ? Image.network(coordinate.imgURL!)
                                    : null,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          PostUserDetailPage(
                                            coordinate.height,
                                            coordinate.tops,
                                            coordinate.bottoms,
                                            coordinate.outer,
                                            coordinate.shoes,
                                            coordinate.accessories,

                                            coordinate.imgURL!,
                                            coordinate.imgTopsURL!,
                                            coordinate.imgBottomsURL!,
                                            coordinate.imgOuterURL!,
                                            coordinate.imgShoesURL!,
                                            coordinate.imgAccessoriesURL!,
                                          ),
                                    ),
                                  );
                                }
                            ),
                          ],
                        ),
                      ),
                )
                    .toList();
                return ListView(
                  children: widgets,
                );
              }),
        ),
        floatingActionButton: Consumer<CoordinateListModel>(
            builder: (context, model, child) {
              return SizedBox(
                width: 70,
                height: 70,
                child: FloatingActionButton(
                  backgroundColor: Colors.black,
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PostCoordinatePage(),
                          fullscreenDialog: true
                      ),
                    );
                    //awaitつける事で、読み込まれるタイミングが変わる。
                    model.fechCoordinateList();
                  },
                  tooltip: 'Increment',
                  child: const Icon(Icons.photo,
                      size: 40,
                      color: Colors.white),
                ),
              );
            }
        ),
      ),
    );
  }
    Future showConfirmDialog(
        BuildContext context,
        Coordinate coordinate,
        CoordinateListModel model,
        ) {
      return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return AlertDialog(
            title: Text("削除の確認"),
            content: Text("『${'この投稿画像'}』を削除しますか？"),
            actions: [
              TextButton(
                child: Text("いいえ"),
                onPressed: () => Navigator.pop(context),
              ),
              TextButton(
                child: Text("はい"),
                onPressed: () async {
                  // modelで削除
                  await model.deleteImgURL(coordinate);
                  Navigator.pop(context);
                  final snackBar = SnackBar(
                    backgroundColor: Colors.black,
                    content: Text('${'投稿画像'}を削除しました'),
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

