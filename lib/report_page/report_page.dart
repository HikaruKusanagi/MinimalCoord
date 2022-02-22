import 'package:flutter/material.dart';
import 'package:minimal_coord/report_page/report_page_model.dart';
import 'package:provider/provider.dart';

class ReportPage extends StatelessWidget {
  ReportPage(
      this.imgURL,
      );
  final  imgURL;

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider<ReportPageModel>(
      create: (_) => ReportPageModel(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          leading: IconButton(
            icon: Icon(
              Icons.close,
              size: 20.0,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text(
            '通報ページ',
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.white,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Consumer<ReportPageModel>(builder: (context, model, child) {
              return Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        GestureDetector(
                          child: SizedBox(
                            height: 300,
                            width: 300,
                            child: Container(
                              decoration: BoxDecoration(color: Colors.grey,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Image.network(imgURL!),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        Row(
                          children: [
                            Text(
                              'メッセージ本文',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 350,
                              height: 200,
                              decoration: BoxDecoration(
                                // 枠線
                                border: Border.all(color: Colors.black, width: 2),
                                // 角丸
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: TextFormField(
                                keyboardType: TextInputType.multiline,
                                maxLength: null,
                                maxLines: null,
                                decoration: InputDecoration(
                                  filled: true,
                                  labelText: '内容を入力',
                                ),
                                textAlign: TextAlign.left,
                                onChanged: (text) {
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 30),
                        ElevatedButton(
                          child:  Text(
                            '送信',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black,
                          ),
                          onPressed: () async {
                            // 追加の処理
                          },
                        ),
                      ],
                    ),
                  ),
                  //読み込んでいる最中
                  if (model.isLoading)
                    Container(
                      color: Colors.black54,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}