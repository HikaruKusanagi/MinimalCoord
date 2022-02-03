import 'package:flutter/material.dart';
import 'package:minimal_coord/domain/coordinate.dart';
import 'package:provider/provider.dart';

import 'configuration_model.dart';

class ConfigurationPage extends StatelessWidget {
  final Coordinate coordinate;
  ConfigurationPage(
      this.coordinate,);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ConfigurationModel>(
      create: (_) => ConfigurationModel(coordinate),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('設定',style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Consumer<ConfigurationModel>(builder: (context, model, child) {
              return Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              child: SizedBox(
                                height: 100,
                                width: 100,
                              ),
                            ),
                            Container(
                              width: 230,
                              child: TextField(
                                keyboardType: TextInputType.number,
                                controller: model.heightController,
                                maxLength: 3,
                                decoration: const InputDecoration(
                                  hintText: '身長',
                                ),
                                onChanged: (text) {
                                  model.setHeight(text);
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: model.isUpdated()
                          ? () async {
                            // 更新の処理
                            try {
                              await model.update();
                              Navigator.of(context).pop(true);
                            } catch (e) {
                              print(e);
                              final snackBar = SnackBar(
                                backgroundColor: Colors.red,
                                content: Text(e.toString()),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          }
                          : null,
                          child: Text('更新',style:TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black,
                          ),
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