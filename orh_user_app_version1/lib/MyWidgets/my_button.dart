import 'package:flutter/material.dart';
import '../global_constant.dart';

class MyButton extends StatelessWidget {
  const MyButton({ Key? key, required this.givenWidth, required this.givenHeight, 
                             required this.btntext, required this.btncolor, required this.givenRadius, required this.givenfontSize }) : super(key: key);
  final double givenWidth;
  final double givenHeight;
  final Color btncolor;
  final String btntext;
  final double givenRadius;
  final double givenfontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
            margin: const EdgeInsets.all(10),
            height: givenHeight,
            width: givenWidth,
            decoration: BoxDecoration(
              color: btncolor,
              boxShadow: [
                BoxShadow(color: btncolor.withOpacity(0.6), spreadRadius: 0.1, blurRadius: 10, offset: const Offset(0, 7))
                ],
              borderRadius: BorderRadius.all(Radius.circular(givenRadius))
            ),
            child:  Center(
              child: Text(btntext,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: givenfontSize),),
              )
          );
  }
}