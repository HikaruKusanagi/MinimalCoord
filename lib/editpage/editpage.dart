import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minimal_coord/editpage/editpage_model.dart';
import 'package:provider/provider.dart';

class EditPage extends StatelessWidget {
  EditPage(this.name);
  final String name;

  @override
  Widget build(BuildContext context) {
  return ChangeNotifierProvider<EditPageModel>(
    create: (_) => EditPageModel(name),
    child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.black,
            onPressed: () {
              Navigator.of(context).pop();
              },
          ),
          title: Text('プロフィール編集',
            style: TextStyle(color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            Consumer<EditPageModel>(
                builder: (context, model, child) {
                  return TextButton(
                    onPressed: model.isUpdated()
                        ? () async {
                      try {
                        await model.update();
                        Navigator.of(context).pop();
                      } catch (e) {
                        final snackBar = SnackBar(
                          backgroundColor: Colors.black,
                          content: Text(e.toString()),
                        );
                        ScaffoldMessenger.of(context)
                            .showSnackBar(snackBar);
                      }
                    }
                    : null,
                    child: Text('決定',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black,
                      ),
                    ),
                  );
                }),
          ],
          backgroundColor: Colors.white.withOpacity(0.0),
          elevation: 0.0,
        ),
      body: Consumer<EditPageModel>(
          builder: (context, model, child) {
            return SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    SizedBox(height: 30),
                    SizedBox(height: 30),
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
                        controller: model.nameController,
                        decoration: const InputDecoration(hintText: '入力'
                        ),
                        onChanged: (text) {
                          model.setName(text);
                        },
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
                        SizedBox(width: 110),
                        SizedBox(

                          child: Column(
                            children: [
                              DropdownButton(
                                icon: Icon(Icons.expand_more),
                                items: const [
                                  DropdownMenuItem(
                                      child: Text('100'),
                                      value: '100'),
                                  DropdownMenuItem(
                                      child: Text('101'),
                                      value: '101'),
                                  DropdownMenuItem(
                                      child: Text('102'),
                                      value: '102'),
                                  DropdownMenuItem(
                                      child: Text('103'),
                                      value: '103'),
                                  DropdownMenuItem(
                                      child: Text('104'),
                                      value: '104'),
                                  DropdownMenuItem(
                                      child: Text('105'),
                                      value: '105'),
                                  DropdownMenuItem(
                                      child: Text('106'),
                                      value: '106'),
                                  DropdownMenuItem(
                                      child: Text('107'),
                                      value: '107'),
                                  DropdownMenuItem(
                                      child: Text('108'),
                                      value: '108'),
                                  DropdownMenuItem(
                                      child: Text('109'),
                                      value: '109'),
                                  DropdownMenuItem(
                                      child: Text('110'),
                                      value: '110'),
                                  DropdownMenuItem(
                                      child: Text('111'),
                                      value: '111'),
                                  DropdownMenuItem(
                                      child: Text('112'),
                                      value: '112'),
                                  DropdownMenuItem(
                                      child: Text('113'),
                                      value: '113'),
                                  DropdownMenuItem(
                                      child: Text('114'),
                                      value: '114'),
                                  DropdownMenuItem(
                                      child: Text('115'),
                                      value: '115'),
                                  DropdownMenuItem(
                                      child: Text('120'),
                                      value: '120'),
                                  DropdownMenuItem(
                                      child: Text('121'),
                                      value: '121'),
                                  DropdownMenuItem(
                                      child: Text('122'),
                                      value: '122'),
                                  DropdownMenuItem(
                                      child: Text('123'),
                                      value: '123'),
                                  DropdownMenuItem(
                                      child: Text('124'),
                                      value: '124'),
                                  DropdownMenuItem(
                                      child: Text('125'),
                                      value: '125'),
                                  DropdownMenuItem(
                                      child: Text('126'),
                                      value: '126'),
                                  DropdownMenuItem(
                                      child: Text('127'),
                                      value: '127'),
                                  DropdownMenuItem(
                                      child: Text('128'),
                                      value: '128'),
                                  DropdownMenuItem(
                                      child: Text('129'),
                                      value: '129'),
                                  DropdownMenuItem(
                                      child: Text('130'),
                                      value: '130'),
                                  DropdownMenuItem(
                                      child: Text('131'),
                                      value: '131'),
                                  DropdownMenuItem(
                                      child: Text('132'),
                                      value: '132'),
                                  DropdownMenuItem(
                                      child: Text('133'),
                                      value: '133'),
                                  DropdownMenuItem(
                                      child: Text('134'),
                                      value: '134'),
                                  DropdownMenuItem(
                                      child: Text('135'),
                                      value: '135'),
                                  DropdownMenuItem(
                                      child: Text('136'),
                                      value: '136'),
                                  DropdownMenuItem(
                                      child: Text('137'),
                                      value: '137'),
                                  DropdownMenuItem(
                                      child: Text('138'),
                                      value: '138'),
                                  DropdownMenuItem(
                                      child: Text('139'),
                                      value: '139'),
                                  DropdownMenuItem(
                                      child: Text('140'),
                                      value: '140'),
                                  DropdownMenuItem(
                                      child: Text('141'),
                                      value: '141'),
                                  DropdownMenuItem(
                                      child: Text('142'),
                                      value: '142'),
                                  DropdownMenuItem(
                                      child: Text('143'),
                                      value: '143'),
                                  DropdownMenuItem(
                                      child: Text('144'),
                                      value: '144'),
                                  DropdownMenuItem(
                                      child: Text('145'),
                                      value: '145'),
                                  DropdownMenuItem(
                                      child: Text('146'),
                                      value: '146'),
                                  DropdownMenuItem(
                                      child: Text('147'),
                                      value: '147'),
                                  DropdownMenuItem(
                                      child: Text('148'),
                                      value: '148'),
                                  DropdownMenuItem(
                                      child: Text('149'),
                                      value: '149'),
                                  DropdownMenuItem(
                                      child: Text('150'),
                                      value: '150'),
                                  DropdownMenuItem(
                                      child: Text('151'),
                                      value: '151'),
                                  DropdownMenuItem(
                                      child: Text('152'),
                                      value: '152'),
                                  DropdownMenuItem(
                                      child: Text('153'),
                                      value: '153'),
                                  DropdownMenuItem(
                                      child: Text('154'),
                                      value: '154'),
                                  DropdownMenuItem(
                                      child: Text('155'),
                                      value: '155'),
                                  DropdownMenuItem(
                                      child: Text('156'),
                                      value: '156'),
                                  DropdownMenuItem(
                                      child: Text('157'),
                                      value: '157'),
                                  DropdownMenuItem(
                                      child: Text('158'),
                                      value: '158'),
                                  DropdownMenuItem(
                                      child: Text('159'),
                                      value: '159'),
                                  DropdownMenuItem(
                                      child: Text('160'),
                                      value: '160'),
                                  DropdownMenuItem(
                                      child: Text('161'),
                                      value: '161'),
                                  DropdownMenuItem(
                                      child: Text('162'),
                                      value: '162'),
                                  DropdownMenuItem(
                                      child: Text('163'),
                                      value: '163'),
                                  DropdownMenuItem(
                                      child: Text('164'),
                                      value: '164'),
                                  DropdownMenuItem(
                                      child: Text('165'),
                                      value: '165'),
                                  DropdownMenuItem(
                                      child: Text('166'),
                                      value: '166'),
                                  DropdownMenuItem(
                                      child: Text('167'),
                                      value: '167'),
                                  DropdownMenuItem(
                                      child: Text('168'),
                                      value: '168'),
                                  DropdownMenuItem(
                                      child: Text('169'),
                                      value: '169'),
                                  DropdownMenuItem(
                                      child: Text('170'),
                                      value: '170'),
                                  DropdownMenuItem(
                                      child: Text('171'),
                                      value: '171'),
                                  DropdownMenuItem(
                                      child: Text('172'),
                                      value: '172'),
                                  DropdownMenuItem(
                                      child: Text('173'),
                                      value: '173'),
                                  DropdownMenuItem(
                                      child: Text('174'),
                                      value: '174'),
                                  DropdownMenuItem(
                                      child: Text('175'),
                                      value: '175'),
                                  DropdownMenuItem(
                                      child: Text('176'),
                                      value: '176'),
                                  DropdownMenuItem(
                                      child: Text('177'),
                                      value: '177'),
                                  DropdownMenuItem(
                                      child: Text('178'),
                                      value: '178'),
                                  DropdownMenuItem(
                                      child: Text('179'),
                                      value: '179'),
                                  DropdownMenuItem(
                                      child: Text('180'),
                                      value: '180'),
                                  DropdownMenuItem(
                                      child: Text('181'),
                                      value: '181'),
                                  DropdownMenuItem(
                                      child: Text('182'),
                                      value: '182'),
                                  DropdownMenuItem(
                                      child: Text('183'),
                                      value: '183'),
                                  DropdownMenuItem(
                                      child: Text('184'),
                                      value: '184'),
                                  DropdownMenuItem(
                                      child: Text('185'),
                                      value: '185'),
                                  DropdownMenuItem(
                                      child: Text('186'),
                                      value: '186'),
                                  DropdownMenuItem(
                                      child: Text('187'),
                                      value: '187'),
                                  DropdownMenuItem(
                                      child: Text('188'),
                                      value: '188'),
                                  DropdownMenuItem(
                                      child: Text('189'),
                                      value: '189'),
                                  DropdownMenuItem(
                                      child: Text('190'),
                                      value: '190'),
                                  DropdownMenuItem(
                                      child: Text('191'),
                                      value: '191'),
                                  DropdownMenuItem(
                                      child: Text('192'),
                                      value: '192'),
                                  DropdownMenuItem(
                                      child: Text('193'),
                                      value: '193'),
                                  DropdownMenuItem(
                                      child: Text('194'),
                                      value: '194'),
                                  DropdownMenuItem(
                                      child: Text('195'),
                                      value: '195'),
                                  DropdownMenuItem(
                                      child: Text('196'),
                                      value: '196'),
                                  DropdownMenuItem(
                                      child: Text('197'),
                                      value: '197'),
                                  DropdownMenuItem(
                                      child: Text('198'),
                                      value: '198'),
                                  DropdownMenuItem(
                                      child: Text('199'),
                                      value: '199'),
                                  DropdownMenuItem(
                                      child: Text('200'),
                                      value: '200'),
                                ],
                                onChanged: (String? value) {
                                  model.isSelectedItem3(value);
                                },
                                value: model.isSelectedItem,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 90),
                        SizedBox(
                          child: DropdownButton(
                            icon: Icon(Icons.expand_more),
                            items: const [
                              DropdownMenuItem(
                                  child: Text('MEN'),
                                  value: 'MEN'),
                              DropdownMenuItem(
                                  child: Text('WOMEN'),
                                  value: 'WOMEN'),
                            ],
                            onChanged: (String? value) {
                              model.isSelectedItem4(value);
                            },
                            value: model.isSelectedItem2,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
    ),
  );
  }
}

