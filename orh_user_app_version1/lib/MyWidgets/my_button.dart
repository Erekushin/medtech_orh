import 'package:flutter/material.dart';

Widget myBtn(Color borderColor, double givenWidth, double givenHeight, Color btncolor, 
             Color textColor, String btntext,[double givenRadius = 10, double givenfontSize = 15, double givenShadowHeight = 7, double givenShadowBlurRadius = 10]){
  return Container(
            margin: const EdgeInsets.all(5),
            height: givenHeight,
            width: givenWidth,
            decoration: BoxDecoration(
              color: btncolor,
              border: Border.all(
                color: borderColor
              ),
              boxShadow: [
                BoxShadow(color: btncolor.withOpacity(0.6), spreadRadius: 0.1, blurRadius: givenShadowBlurRadius, offset: Offset(0, givenShadowHeight))
                ],
              borderRadius: BorderRadius.all(Radius.circular(givenRadius))
            ),
            child:  Center(
              child: Text(btntext,
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: givenfontSize),),
              )
          );
}