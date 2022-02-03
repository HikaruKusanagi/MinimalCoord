
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minimal_coord/configuration/configuration_page.dart';
import 'package:minimal_coord/domain/coordinate.dart';
import 'package:minimal_coord/google_signin_page/google_singin_model.dart';
import 'package:minimal_coord/profile_page/profile_model.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {

  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider<ProfileModel>(
      create: (_) => ProfileModel()..fechCoordinateList(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('Profile',style: GoogleFonts.yuseiMagic(
            textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          ),
          centerTitle: false,
          actions: [
            TextButton(
              child: Text('Logout',style: GoogleFonts.yuseiMagic(
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ),
              onPressed: () {
                final provider = Provider.of<GoogleSigInModel>(context, listen: false);
                provider.logout();
              },
            ),
          ],
        ),
        body: Center(
          child: Consumer<ProfileModel>(builder: (context, model, child) {
            final List<Coordinate>? coordinate = model.coordinate;
            if (coordinate == null) {
              return const CircularProgressIndicator();
            }

            final List<Widget> widgets = coordinate
                .map(
                  (coordinate) =>
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 200,
                          width: 200,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ConfigurationPage(
                                        coordinate,
                                      ),
                                ),
                              );
                            },
                            child: Card(
                              color: Colors.white,
                              child: Center(
                                child: ListTile(
                                  leading: CircleAvatar(radius: 40,backgroundImage: NetworkImage(user.photoURL!),),
                                  title: Text(user.displayName!,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text(coordinate.height + 'cm',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
            )
                .toList();
            model.fechCoordinateList();
            return ListView(
              physics: const NeverScrollableScrollPhysics(),
              children: widgets,
            );
          }),
        ),
        ),
      );
  }
}