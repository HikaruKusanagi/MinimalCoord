import 'package:flutter/material.dart';

class VisibilitySample extends StatefulWidget {
  const VisibilitySample({Key? key}) : super(key: key);

  @override
  _VisibilitySampleState createState() => _VisibilitySampleState();
}

class _VisibilitySampleState extends State<VisibilitySample> {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Visibility(
                visible: isVisible,
                child: const Text('Visibilityテスト'),
              ),
              TextButton(
                onPressed: () {
                  setState(toggleShowText);
                },
                style: TextButton.styleFrom(
                    backgroundColor: Colors.white
                ),
                child: Text('クリックミー'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void toggleShowText(){
    isVisible = !isVisible;
  }
}