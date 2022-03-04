import 'package:flutter/material.dart';

import '../Helpers/CreatedGlobalWidgets/bottom_nav_bar.dart';

class DoctorProfile extends StatefulWidget {
  const DoctorProfile({Key? key}) : super(key: key);

  @override
  _DoctorProfileState createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        shadowColor: Colors.black.withOpacity(.5),
        title: Text(
          'Doctor Profile',
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
      bottomNavigationBar: MyBottomNavBar(),
      body: Container(
        child: Center(
          child: Text('Doctor Profile Page'),
        ),
      ),
    );
  }
}
