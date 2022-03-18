import 'package:flutter/material.dart';

import '../Helpers/CreatedGlobalWidgets/bottom_nav_bar.dart';
class HospitalProfile extends StatefulWidget {
  const HospitalProfile({Key? key}) : super(key: key);

  @override
  _HospitalProfileState createState() => _HospitalProfileState();
}

class _HospitalProfileState extends State<HospitalProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        shadowColor: Colors.black.withOpacity(.5),
        title: Text(
          'Hospital Profile',
          style: TextStyle(
              color: Colors.black.withOpacity(.7),
              fontWeight: FontWeight.w600,
              letterSpacing: 1),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black.withOpacity(.4),
          ),
          onPressed: () => Navigator.maybePop(context),
        ),
      ),
      bottomNavigationBar: MyBottomNavbar(),
      body: Container(child: Center(child: Text("Hospital profile"),),),
    );
  }
}
