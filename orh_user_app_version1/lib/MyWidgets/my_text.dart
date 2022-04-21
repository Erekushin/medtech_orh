import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
Widget myText(String txt, double size, double txtheight, [FontWeight txtWeight = FontWeight.w400]){
  return Text(
    txt,
    maxLines: 3,
    softWrap: true,
    overflow: TextOverflow.ellipsis,
    style: GoogleFonts.openSans(height: txtheight, fontWeight: txtWeight, fontSize: size,
    color: Colors.black.withOpacity(.5)),);
}