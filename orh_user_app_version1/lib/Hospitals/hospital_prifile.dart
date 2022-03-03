import 'package:flutter/material.dart';
class HospitalProfile extends StatefulWidget {
  const HospitalProfile({Key? key}) : super(key: key);

  @override
  _HospitalProfileState createState() => _HospitalProfileState();
}

class _HospitalProfileState extends State<HospitalProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(child: Center(child: Text("Hospital profile"),),),
    );
  }
}
