import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minimal_coord/rule_page/rule_page.dart';
import 'package:minimal_coord/signin_page/singin_model.dart';
import 'package:provider/provider.dart';
import 'package:sign_button/sign_button.dart';


class SigInPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SigInModel>(
      create: (_) => SigInModel(),
      child: Scaffold(
        body: Column(
            children: [
              const SizedBox(height: 200),
              Flexible(
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        'MinimalCoord',
                        style: GoogleFonts.yuseiMagic(
                          textStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        'すくなく、オシャレに',
                        style: GoogleFonts.yuseiMagic(
                          textStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Consumer(builder: (context, model, child) {
                return SignInButton(
                  buttonType: ButtonType.google,
                  buttonSize: ButtonSize.small,
                  onPressed: () {
                    final provider =
                    Provider.of<SigInModel>(context, listen: false);
                    provider.googleLogin();
                  },
                );
              },
              ),
              const SizedBox(height: 20),
              Consumer(builder: (context, model, child) {
                return SizedBox(
                  width: 235,
                    child: SignInButton(
                      buttonType: ButtonType.apple,
                      buttonSize: ButtonSize.small,
                      onPressed: () async {
                        final provider =
                        Provider.of<SigInModel>(context, listen: false);
                        provider.appleLogin();
                        },
                    ),
                );
              },
              ),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RulePage(),
                      fullscreenDialog: true,
                      ),
                    );
                  },
                  child: const Text(
                    '利用規約',
                    style: TextStyle(
                      fontSize: 15,
                        color: Colors.black
                    ),
                  ),
                ),
              ),
              SizedBox(height: 100),
            ]),
      ),
    );
  }
}