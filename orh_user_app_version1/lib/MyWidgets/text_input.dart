import 'package:flutter/material.dart';
class MyTextField extends StatelessWidget {
  MyTextField({Key? key, required this.givenHeight, required this.givenWidth, 
                         required this.controller, required this.hint, 
                         required this.label, required this.givenMargin,
                         required this.givenRadius }) : super(key: key);
  final double givenWidth;
  final double givenHeight;
  final double givenMargin;
  TextEditingController controller;
  final String hint;
  final String label;
  final double givenRadius;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.all(givenMargin),
      width: givenWidth,
      height: givenHeight,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(givenRadius),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 40,
            spreadRadius: 10,
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          focusedBorder: const OutlineInputBorder(
            borderSide:  BorderSide(color: Colors.white),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide:  BorderSide(color: Colors.white),
          ),
          fillColor: Colors.white,
          filled: true,
          hintText: hint,
          labelText: label,
        ),
      ),
    );
  }
}
