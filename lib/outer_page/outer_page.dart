import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minimal_coord/coordinate_list/coordinate_list_model.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';

class OuterPage extends StatelessWidget {

  OuterPage(
      this.outer,
      this.imgOuterURL,
      );

  final outer;
  final imgOuterURL;

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
                      imageProvider: NetworkImage(imgOuterURL!)),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(outer,
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