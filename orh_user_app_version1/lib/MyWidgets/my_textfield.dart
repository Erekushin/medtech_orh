import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
Widget myTextField(String hinttxt, var txtController, double margint, 
                   double marginb, double marginr, double marginl){
  return Container(
    padding: EdgeInsets.only(top: margint, bottom: marginb, left: marginr, right: marginl),
    child: TextField(
      controller: txtController,
      decoration: InputDecoration(
      hintText: hinttxt,
                  ),
                ),
  );
}