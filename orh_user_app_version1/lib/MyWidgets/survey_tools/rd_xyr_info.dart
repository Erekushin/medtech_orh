import 'package:flutter/material.dart';
import 'package:orh_user_app_version1/MyWidgets/my_text.dart';
import '../my_textfield.dart';

var rdTxtController = TextEditingController();
Widget rdXyrInfo(String hinttxt, String questionID, int answerIdx){
  return Container(
    margin: const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(15))
      ),
      child: Column(
        children: [
          MyTextField(hinttxt: hinttxt, txtController: rdTxtController, marginb: 5, marginl: 5, 
                          marginr: 5, margint: 5, questionID: questionID, answerIndex: answerIdx, mark: 'rd',),
          myText('рд оруулсанаар судлаач таний хувийн мэдээллийг иргэний мэдээллийн сангаас авах юм',
           15, 1)               
        ],
      ),
  );
}