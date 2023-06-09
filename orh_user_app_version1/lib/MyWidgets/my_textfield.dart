import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controllers/query_controller.dart';
Widget myTextField(String hinttxt, TextEditingController txtController, double margint, 
                   double marginb, double marginr, double marginl, int questionID,
                   int answerIndex, String mark){
                     
  final queryController = Get.find<SurveyController>(); 
  switch(mark){
    case 'query' :
     return Container(
    padding: EdgeInsets.only(top: margint, bottom: marginb, left: marginr, right: marginl),
    child: TextField(
      onChanged: (value){
          queryController.queryAnswer.answers![answerIndex].questionId = questionID;
          queryController.queryAnswer.answers![answerIndex].answerText = value;
        },
      controller: txtController,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(4),
      labelText: hinttxt,  
      hintText: hinttxt,
                  ),
                ),
       );
       case 'rd' :
     return Container(
    padding: EdgeInsets.only(top: margint, bottom: marginb, left: marginr, right: marginl),
    child: TextField(
      maxLength: 10,
      onChanged: (value){
          if(txtController.text.length == 10){
            queryController.xyrInfoGet();
          }
        },
      controller: txtController,
      decoration: InputDecoration(
      hintText: hinttxt,
      labelText: hinttxt
                  ),
                ),
       );
    default: return const SizedBox();   
  } 
}