import 'package:flutter/material.dart';
import 'package:minimal_coord/mypage/mypage_model.dart';
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
          title: Text('プロフィール編集',
            style: TextStyle(color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
        TextButton(
            onPressed:() {},
          child: Text('決定',
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
                Row(
                  children: [
                    SizedBox(width: 20),
                    Text('名前', style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                SizedBox(
                  width: 330,
                  child: TextField(
                    decoration: InputDecoration(),
                  ),
                ),
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
                    SizedBox(width: 120),
                    SizedBox(
                      width: 55,
                      child: DropdownButton(
                        icon: Icon(Icons.expand_more),
                        items: const [
                          DropdownMenuItem(
                              child: Text('150'),
                              value: '150'),
                          DropdownMenuItem(
                              child: Text('160'),
                              value: '160'),
                          DropdownMenuItem(
                              child: Text('170'),
                              value: '170'),
                        ],
                        onChanged: (text) {
                          model.isSelectedItem();
                        },
                      ),
                    ),
                    SizedBox(width: 120),
                    SizedBox(
                      width: 60,
                      child: DropdownButton(
                        icon: Icon(Icons.expand_more),
                        items: const [
                          DropdownMenuItem(
                              child: Text('男性'),
                              value: '男性'),
                          DropdownMenuItem(
                              child: Text('女性'),
                              value: '女性'),
                        ],
                        onChanged: (text) {
                          model.isSelectedItem();
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    )
  );
  }
}

