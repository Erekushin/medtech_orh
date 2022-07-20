import 'package:flutter/material.dart';
import 'package:orh_user_app_version1/MyWidgets/my_text.dart';
import 'package:get/get.dart';

import '../../Controllers/SurveyRelated/survey_controller.dart';



class MessageTxt extends StatefulWidget {
  const MessageTxt({Key? key, required this.hintText, required this.questionID, required this.answerIndex}) : super(key: key);
  final String hintText;
  final String questionID;
  final int answerIndex;
  @override
  State<MessageTxt> createState() => _MessageTxtState();
}

class _MessageTxtState extends State<MessageTxt> {
  final sCont = Get.find<SCont>(); 
  @override
  void initState() {
    super.initState();
    if(widget.questionID != "null"){
      sCont.surveyAnswer.answers![widget.answerIndex].questionId = int.parse(widget.questionID);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(15))
      ),
      margin: const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
      child: myText(widget.hintText, 15, 1),
    );
  }
}