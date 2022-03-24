import 'package:flutter/material.dart';

class ProfileLifeToken extends StatefulWidget {
  const ProfileLifeToken({ Key? key }) : super(key: key);

  @override
  State<ProfileLifeToken> createState() => _ProfileLifeTokenState();
}

class _ProfileLifeTokenState extends State<ProfileLifeToken> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('life token'),
      ),
    );
  }
}