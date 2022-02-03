import 'package:flutter/material.dart';
import 'package:minimal_coord/bottom_navigation_bar/bttom_navigation_bar.model.dart';
import 'package:minimal_coord/coordinate_list/coordinate_list_page.dart';
import 'package:minimal_coord/profile_page/profile_page.dart';
import 'package:provider/provider.dart';

class BottomNavigationBarPage extends StatelessWidget {



  final currentTab = [
    CoordinateListPage(),
    ProfilePage(),
  ];

  final List<String> _tabNames = ['タイムライン','プロフィール',];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BottomNavigationBarModel>(
      create: (_) => BottomNavigationBarModel(),
      child: Consumer<BottomNavigationBarModel>(
          builder: (context, model, child) {
            return Scaffold(
              //currentIndex:現在、選択されているindex。このindexのアイコンが選択状態になる
              body: currentTab[model.currentIndex],
              // bottomNavigationBar: BottomNavigationBar(
              //   currentIndex: model.currentIndex,
              //   type: BottomNavigationBarType.fixed,
              //   fixedColor: Colors.black,
              //   backgroundColor: Colors.white,
              //   //アイコンをタップしたときの処理。
              //   onTap: (index) {
              //     model.onTabTapped(index);
              //   },
              //   items: [
              //     BottomNavigationBarItem(
              //       icon: const Icon(Icons.checkroom),
              //       label: _tabNames[0],
              //     ),
              //     BottomNavigationBarItem(
              //       icon: const Icon(Icons.face),
              //       label: _tabNames[1],
              //     ),
              //   ],
              // ),
            );
          }),
    );
  }
}