import 'package:flutter/material.dart';
class MyTextField extends StatelessWidget {
  MyTextField({Key? key, required this.w, required this.controller, required this.hint, required this.label}) : super(key: key);
  final double w;
  TextEditingController controller;
  final String hint;
  final String label;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(bottom: w / 40, left: 10, right: 10, top: w/40),
      height: w / 4,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
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
