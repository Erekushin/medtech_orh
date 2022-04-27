import 'package:get/get.dart';
import 'package:flutter/material.dart';

class WaitingScreen extends StatefulWidget {
  const WaitingScreen({Key? key}) : super(key: key);

  @override
  _WaitingScreenState createState() => _WaitingScreenState();
}

class _WaitingScreenState extends State<WaitingScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            SizedBox(height: 50,),
            Center(child: CircularProgressIndicator()),
            SizedBox(height: 230,),
            Image.asset('assets/images/thinkingBoy.png'),
          ],
        ),
      ),
    );
  }
}
