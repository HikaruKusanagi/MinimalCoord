import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minimal_coord/post_coordinate/post_coordnate_page.model.dart';
import 'package:provider/provider.dart';

class PostCoordinatePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final user = FirebaseAuth.instance.currentUser!.uid;
    print('user; $user');
    return ChangeNotifierProvider<PostCoordinatePageModel>(
      create: (_) => PostCoordinatePageModel(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('PostPage',style: GoogleFonts.yuseiMagic(
            textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          ),
          centerTitle: false,
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Consumer<PostCoordinatePageModel>(builder: (context, model, child) {
              return Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        SizedBox(height: 30),
                        GestureDetector(
                          child: SizedBox(
                            height: 300,
                            width: 300,
                            child: model.imageFile != null
                                ? Image.file(model.imageFile!)
                                : Container(
                              child: const Center(
                                child: Icon(Icons.add_a_photo,color: Colors.white, size: 200),
                              ),
                              color: Colors.grey,
                            ),
                          ),
                          onTap: () async {
                            await model.pickImage();
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            Text('Height🧍‍♀️',style: GoogleFonts.yuseiMagic(
                              textStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              width: 230,
                              child: TextField(
                                keyboardType: TextInputType.number,
                                maxLength: 3,
                                decoration: const InputDecoration(
                                  hintText: '身長',
                                ),
                                onChanged: (text) {
                                  model.height = text;
                                },
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Tops👕',style: GoogleFonts.yuseiMagic(
                              textStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              child: SizedBox(
                                height: 100,
                                width: 100,
                                child: model.topsImageFile != null
                                    ? Image.file(model.topsImageFile!)
                                    : Container(
                                  child: const Center(
                                    child:   Icon(Icons.add_a_photo,color: Colors.white),
                                  ),
                                  color: Colors.grey,
                                ),
                              ),
                              onTap: () async {
                                await model.topsImage();
                              },
                            ),
                            Container(
                              width: 230,
                              child: TextField(
                                maxLength: 7,
                                decoration: const InputDecoration(
                                  hintText: 'Tops',
                                ),
                                onChanged: (text) {
                                  model.tops = text;
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            Text('Bottoms👖',style: GoogleFonts.yuseiMagic(
                              textStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              child: SizedBox(
                                height: 100,
                                width: 100,
                                child: model.bottomsImageFile != null
                                    ? Image.file(model.bottomsImageFile!)
                                    : Container(
                                  child: const Center(
                                    child:   Icon(Icons.add_a_photo,color: Colors.white,),
                                  ),
                                  color: Colors.grey,
                                ),
                              ),
                              onTap: () async {
                                await model.bottomsImage();
                              },
                            ),
                            Container(
                              width: 230,
                              child: TextField(
                                maxLength: 7,
                                decoration: const InputDecoration(
                                  hintText: 'Bottoms',
                                ),
                                onChanged: (text) {
                                  model.bottoms = text;
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            Text('Outer🧥',style: GoogleFonts.yuseiMagic(
                              textStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              child: SizedBox(
                                height: 100,
                                width: 100,
                                child: model.outerImageFile != null
                                    ? Image.file(model.outerImageFile!)
                                    : Container(
                                  child: const Center(
                                    child:   Icon(Icons.add_a_photo,color: Colors.white,),
                                  ),
                                  color: Colors.grey,
                                ),
                              ),
                              onTap: () async {
                                await model.outerImage();
                              },
                            ),
                            Container(
                              width: 230,
                              child: TextField(
                                maxLength: 7,
                                decoration: const InputDecoration(
                                  hintText: 'Outer',
                                ),
                                onChanged: (text) {
                                  model.outer = text;
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text('Shoes👞',style: GoogleFonts.yuseiMagic(
                              textStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              child: SizedBox(
                                height: 100,
                                width: 100,
                                child: model.shoesImageFile != null
                                    ? Image.file(model.shoesImageFile!)
                                    : Container(
                                  child: const Center(
                                    child:   Icon(Icons.add_a_photo,color: Colors.white,),
                                  ),
                                  color: Colors.grey,
                                ),
                              ),
                              onTap: () async {
                                await model.shoesImage();
                              },
                            ),
                            Container(
                              width: 230,
                              child: TextField(
                                maxLength: 7,
                                decoration: const InputDecoration(
                                  hintText: 'Shoes',
                                ),
                                onChanged: (text) {
                                  model.shoes = text;
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text('Accessories🧣',style: GoogleFonts.yuseiMagic(
                              textStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              child: SizedBox(
                                height: 100,
                                width: 100,
                                child: model.accessoriesImageFile != null
                                    ? Image.file(model.accessoriesImageFile!)
                                    : Container(
                                  child: const Center(
                                    child: Icon(Icons.add_a_photo,color: Colors.white,),
                                  ),
                                  color: Colors.grey,
                                ),
                              ),
                              onTap: () async {
                                await model.accessoriesImage();
                              },
                            ),
                            Container(
                              width: 230,
                              child: TextField(
                                maxLength: 7,
                                decoration: const InputDecoration(
                                  hintText: 'Accessories',
                                ),
                                onChanged: (text) {
                                  model.accessories = text;
                                },
                              ),
                            ),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            // 追加の処理
                            try {
                              model.startLoading();
                              await model.addCoordinate();
                              Navigator.of(context).pop(true);
                            } catch (e) {
                              print(e);
                              final snackBar = SnackBar(
                                backgroundColor: Colors.black,
                                content: Text(e.toString()),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } finally {
                              model.endLoading();
                            }
                          },
                          child: Text('投稿',style:
                           TextStyle(
                              color: Colors.white,
                              fontSize: 15,
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
                      height: 300,
                      width: 300,
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