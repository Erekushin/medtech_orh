import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orh_user_app_version1/Controllers/setting_controller.dart';
import '../Controllers/SurveyRelated/survey_controller.dart';

class MyTextField extends StatefulWidget {
  const MyTextField({ Key? key, required this.hinttxt, required this.txtController,
                      required this.margint, required this.marginb, required this.marginr, 
                      required this.marginl, required this.questionID, required this.answerIndex,
                      required this.mark }) : super(key: key);
  final String hinttxt;
  final TextEditingController txtController;
  final double margint;
  final double marginb;
  final double marginr;
  final double marginl;
  final String questionID;
  final int answerIndex;
  final String mark;
  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
   final surveyController = Get.find<SCont>(); 
  final settingsController = Get.find<SettingController>();
  @override
  void initState() {
    super.initState();
    if(widget.questionID != "null"){
      surveyController.surveyAnswer.answers![widget.answerIndex].questionId = int.parse(widget.questionID);
    }
  }
  @override
  Widget build(BuildContext context) {
    switch(widget.mark){
    case 'query' :
     return Container(
    padding: EdgeInsets.only(top: widget.margint, bottom: widget.marginb, left: widget.marginr, right: widget.marginl),
    child: TextField(
      onChanged: (value){
          surveyController.surveyAnswer.answers![widget.answerIndex].questionId = int.parse(widget.questionID);
          surveyController.surveyAnswer.answers![widget.answerIndex].answerText = value;
        },
      controller: widget.txtController,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(4),
      labelText: widget.hinttxt,  
      hintText: widget.hinttxt,
                  ),
                ),
       );
        case 'onlyNumber' :
     return Container(
    padding: EdgeInsets.only(top: widget.margint, bottom: widget.marginb, left: widget.marginr, right: widget.marginl),
    child: TextField(
      keyboardType: TextInputType.number,
      onChanged: (value){
        if(value != ""){
          surveyController.surveyAnswer.answers![widget.answerIndex].questionId = int.parse(widget.questionID);
          surveyController.surveyAnswer.answers![widget.answerIndex].answerDigit = int. parse(value);
        }
        },
      controller: widget.txtController,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(4),
      labelText: widget.hinttxt,  
      hintText: widget.hinttxt,
                  ),
                ),
       );
       case 'rd' :
     return Container(
    padding: EdgeInsets.only(top: widget.margint, bottom: widget.marginb, left: widget.marginr, right: widget.marginl),
    child: TextField(
      maxLength: 10,
      onChanged: (value){
          if(settingsController.xyrServiceSwitcher.value){
            if(widget.txtController.text.length == 10){
          }
          }
        },
      controller: widget.txtController,
      decoration: InputDecoration(
      hintText: widget.hinttxt,
      labelText: widget.hinttxt
                  ),
                ),
       );
    default: return const SizedBox();   
  } 
  }
}
