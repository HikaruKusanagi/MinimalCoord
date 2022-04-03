import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minimal_coord/coordinate_list/coordinate_list_model.dart';
import 'package:minimal_coord/domain/coordinate.dart';
import 'package:minimal_coord/google_signin_page/google_singin_model.dart';
import 'package:minimal_coord/post_coordinate/post_coordinate_page.dart';
import 'package:minimal_coord/post_user_detail/post_user_detail_page.dart';
import 'package:minimal_coord/rule_page/rule_page.dart';
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
            foregroundColor: Colors.black,
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
              PopupMenuButton(
                itemBuilder: (context) => [
                PopupMenuItem(
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                        MaterialPageRoute(builder: (context) =>
                            RulePage(),
                        ),
                      );
                    },
                    child: Text('お問い合わせ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: Colors.black
                      ),
                    ),
                  ),
                ),
                  PopupMenuItem(
                    child: TextButton(
                      onPressed: () async {
                          await LogOutDialog(context);
                      },
                      child: Text('ログアウト',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: Colors.black
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ]),
        body: Consumer<CoordinateListModel>(
        builder: (context, model, child) {
          final List<Coordinate>? coordinate = model.coordinate;
          if (coordinate == null) {
            return Center(child: const CircularProgressIndicator(
              color: Colors.black,
            ));
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
                          Card(
                            color: Colors.white,
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
                                           coordinate
                                          ),
                                    ),
                                  );
                                }
                            ),
                          ),
                        ],
                      ),
                    ),
          )
              .toList();
          model.blockList(uid);
          return ListView(children: widgets);
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
          }
        ),
      ),
    );}

  Future LogOutDialog(
      BuildContext context,
      ) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          title: Text("確認"),
          content: Text('ログアウトしますか？'),
          actions: [
            TextButton(
              child: Text("いいえ"),
              onPressed: () =>
                Navigator.of(context).popUntil((route) => route.isFirst),
            ),
            TextButton(
              child: Text("はい"),
              onPressed: () async {
                final provider = Provider.of<GoogleSigInModel>(
                    context, listen: false);
                provider.logout(context);
                },
            ),
          ],
        );
      },
    );
  }
}


// Image.network(coodinate.imgURL!, fit: BoxFit.cover,);
// Swiper(
// itemBuilder: (BuildContext context, int index) {
// print(index);
// final coodinate = model.coordinate![index];
// itemCount: model.coordinate!.length,
// scale: 0.7,
// viewportFraction: 0.8,
// pagination: SwiperPagination(),