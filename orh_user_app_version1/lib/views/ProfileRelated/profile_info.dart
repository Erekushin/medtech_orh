import 'package:flutter/material.dart';
class ProfileInfo extends StatefulWidget {
  const ProfileInfo({ Key? key }) : super(key: key);

  @override
  State<ProfileInfo> createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text('data', style: TextStyle(fontSize: 30),),
          ],
        ),
      ),
    );
  }
}