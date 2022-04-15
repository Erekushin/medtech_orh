import 'package:flutter/material.dart';

class CircleDayPresenter extends StatefulWidget {
  const CircleDayPresenter({Key? key,required this.HourText}) : super(key: key);
  final String HourText;
  @override
  _CircleDayPresenter createState() => _CircleDayPresenter();
}

class _CircleDayPresenter extends State<CircleDayPresenter> {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Color(0xFFB9B9B9),
      child: Text(widget.HourText, style: TextStyle(color: Colors.white ),),
    );
  }
}
