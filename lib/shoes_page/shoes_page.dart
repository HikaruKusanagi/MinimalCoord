import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minimal_coord/coordinate_list/coordinate_list_model.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';

class ShoesPage extends StatelessWidget {

  ShoesPage(
      this.shoes,
      this.imgShoesURL,
      );

  final shoes;
  final imgShoesURL;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CoordinateListModel>(
      create: (_) => CoordinateListModel(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('Item', style: GoogleFonts.yuseiMagic(
            textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 500,
                width: 500,
                child: Card(
                  color: Colors.white,
                  child: PhotoView(
                      imageProvider: NetworkImage(imgShoesURL!)),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(shoes,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}