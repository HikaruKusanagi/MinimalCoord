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
import 'package:minimal_coord/test.dart';
import 'package:provider/provider.dart';

class CoordinateListPage extends StatelessWidget {

  final user = FirebaseAuth.instance.currentUser!;
  bool _isShow = true;

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
                  final provider = Provider.of<GoogleSigInModel>(context, listen: false);
                  provider.logout();
                }),
              ]
            ),
        body: Center(
          child: Consumer<CoordinateListModel>(builder: (context, model, child) {
            final List<Coordinate>? coordinate = model.coordinate;
            if (coordinate == null) {
              return const CircularProgressIndicator();
            }
            final List<Widget> widgets = coordinate
                .map(
                  (coordinate) => Card(
                    color: Colors.white,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: 160),
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
                            SizedBox(width: 20),
                            ElevatedButton(
                              onPressed: () {
                                model.toggleShowText;
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.black,
                              ),
                              child: Text('ブロック',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Visibility(
                          visible: model.isVisible,
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
        floatingActionButton: Consumer<CoordinateListModel>(builder: (context, model, child) {
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
}
