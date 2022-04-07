import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
Widget myText(String txt, double size, double txtheight, [FontWeight txtWeight = FontWeight.w400]){
  return Text(
    txt,
    style: GoogleFonts.openSans(height: txtheight, fontWeight: txtWeight, fontSize: size),);
}