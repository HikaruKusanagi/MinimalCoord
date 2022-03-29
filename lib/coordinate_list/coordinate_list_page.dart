import 'package:card_swiper/card_swiper.dart';
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
import 'package:provider/provider.dart';

class CoordinateListPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    print('uid; $uid');
    return ChangeNotifierProvider<CoordinateListModel>(
      create: (_) =>
      CoordinateListModel()..fechCoordinateList()..blockList(uid),
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
              // IconButton(
              //     icon: const Icon(Icons.account_box),
              //     color: Colors.black,
              //     onPressed: () {
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(builder: (context) => BlockListPage()),
              //       );
              //     }),
              IconButton(
                  icon: const Icon(Icons.logout),
                  color: Colors.black,
                  onPressed: () {
                    final provider = Provider.of<GoogleSigInModel>(
                        context, listen: false);
                    provider.logout();
                  }),
            ]),
        body: Consumer<CoordinateListModel>(
            builder: (context, model, child) {
              final List<Coordinate>? coordinate = model.coordinate;
              if (coordinate == null) {
                return const CircularProgressIndicator();
              }
              final List<Widget> widgets = coordinate
                  .map(
                    (coordinate) =>
                    Visibility(
                      // containsを使用すると、blockIdsにcoordinateのuidが含まれているか、いないか
                      //判別できる(trueかfalse)
                      visible: !(model.blockIds?.contains(coordinate.uid) ??
                          false),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
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
                                            ReportPage(),
                                      ),
                                    ),
                              ),
                              IconButton(
                                  icon: Icon(Icons.person_off),
                                  onPressed: () async {
                                    final userId = coordinate.uid;
                                    print('userId; $userId');
                                    await blockUserDialog(
                                        context, coordinate, model);
                                  }
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 450,
                            width: 450,
                            child: Card(
                              color: Colors.grey,
                              child: ListTile(
                                  title: coordinate.imgURL != null
                                      ? Image.network(coordinate.imgURL!)
                                      : null,
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            PostUserDetailPage(
                                              coordinate.uid,
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
                            ),
                          ),
                        ],
                      ),
                    ),
              )
                  .toList();
              model.blockList(uid);
              return Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return PageView(
                    children: widgets,
                  );
                },
                itemCount: 3,
                scale: 0.9,
                pagination: SwiperPagination(),
                control: SwiperControl(
                  color: Colors.black
                ),
              );
            }),
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
        },
        ),
    ),
    );
  }
  Future blockUserDialog(
      BuildContext context,
      Coordinate coordinate,
      CoordinateListModel model,) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          title: Text("ブロックの確認"),
          content: Text('この投稿ユーザーをブロックしますか？'),
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
                Navigator.pop(context);
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