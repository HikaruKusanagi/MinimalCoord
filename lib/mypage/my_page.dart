import 'package:flutter/material.dart';
import 'package:minimal_coord/editpage/editpage.dart';
import 'package:minimal_coord/mypage/my_page.model.dart';
import 'package:provider/provider.dart';

class MyPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MyPageModel>(
      create: (_) => MyPageModel(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.black,
            onPressed: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
          ),
          title: Text('ひかる',
            style: TextStyle(color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            TextButton(
              onPressed:() {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>
                        EditPage(),
                    ),
                );
              },
              child: Text('編集',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.black,
                ),
              ),
            ),
          ],
          backgroundColor: Colors.white.withOpacity(0.0),
          elevation: 0.0,
        ),
        body: Consumer<MyPageModel>(
            builder: (context, model, child) {
              return SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(height: 30),
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(''),
                        backgroundColor: Colors.grey,
                      ),
                      SizedBox(height: 30),
                      Text('写真を選ぶ'),
                      SizedBox(height: 30),
                      Row(
                        children: [
                          SizedBox(width: 20),
                          Text('身長', style: TextStyle(color: Colors.grey),),
                          SizedBox(width: 160),
                          Text('性別', style: TextStyle(color: Colors.grey),),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(width: 100),
                          Text('165cm',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(width: 150),
                          Text('男性',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 120),
                      SizedBox(width: 55),
                      SizedBox(width: 120),

                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}