import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:minimal_coord/block_list_page/block_list_model.dart';
import 'package:provider/provider.dart';


class BlockListPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldMessengerKey = GlobalKey<ScaffoldState>();
    final uid = FirebaseAuth.instance.currentUser!.uid;
    return ChangeNotifierProvider<BlockListModel>(
      create: (_) =>
      BlockListModel()..blockList(uid),
      child: Scaffold(
        key: scaffoldMessengerKey,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            'ブロックリスト',
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
        body: Center(
          child: Consumer<BlockListModel>(builder: (context, model, child) {
            final List<String>? blockIds = model.blockIds;

            if (blockIds == null) {
              return CircularProgressIndicator();
            }

            final List<Widget> widgets = blockIds
                .map(
                  (blockIds) => Slidable(
                    endActionPane: ActionPane(
                      extentRatio: 0.65,
                      motion: ScrollMotion(),
                      children: [
                        SlidableAction(
                          label: '解除',
                          icon: Icons.person_add,
                          backgroundColor: Colors.black,
                          onPressed: (context) async =>
                              await blockUserDialog(
                                  scaffoldMessengerKey,
                                  context,blockIds,uid,model),
                        ),
                        SlidableAction(
                          label: '閉じる',
                          icon: Icons.close,
                          backgroundColor: Colors.grey,
                          onPressed: null,
                        ),
                      ],
                    ),
                    child: ListTile(
                      title: Text(
                        blockIds,
                        style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                        ),
                      ),
                    ),
                  ),
            )
                .toList();
            return ListView(
              children: widgets,
            );
          }),
        ),
      ),
    );
  }
}
Future blockUserDialog(
    scaffoldMessengerKey,
    BuildContext context,
    String blockIds, uid,
    BlockListModel model,) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) {
      return AlertDialog(
        title: Text("解除の確認"),
        content: Text('ブロックしたユーザーを解除しますか？'),
        actions: [
          TextButton(
            child: Text("いいえ"),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: Text("はい"),
            onPressed: () async {
              // await model.delete(uid);
              // Navigator.pop(context);
              // final snackBar = SnackBar(
              //   backgroundColor: Colors.black,
              //   content: Text('ブロックを解除しました'),
              // );
              // model.blockList(uid);
              // ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
          ),
        ],
      );
    },
  );
}