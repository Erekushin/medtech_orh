import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orh_user_app_version1/Controllers/survey_controller.dart';
import 'package:orh_user_app_version1/MyWidgets/my_dropdown.dart';
import 'package:orh_user_app_version1/MyWidgets/my_textfield.dart';
import 'package:orh_user_app_version1/models/SurveyRelated/survey_question_body.dart';
import '../../MyWidgets/my_textfield.dart';

///хариултыг оруулах item 
class RecieverUnit extends StatefulWidget {
  const RecieverUnit({ Key? key,required this.questionID, this.type,
                       this.questionText, required this.questionIndex,
                       this.options}) 
  : super(key: key);
  final String questionID;
  final type;
  final questionText;
  final int questionIndex;
  final List<Options>? options;
  @override
  State<RecieverUnit> createState() => _RecieverUnit();
}
class _RecieverUnit extends State<RecieverUnit> {
  var queryController = Get.find<SurveyController>();
  Widget categorization(int type){
    switch (type) {
        case 0:
          return MyTextField(hinttxt:widget.questionText, txtController:queryController.textEditingControllers[widget.questionIndex], margint: 5, marginb: 5, 
          marginr: 20, marginl:  20, 
                            questionID: widget.questionID, answerIndex: widget.questionIndex, mark: 'query');                        
        default: return MyDropdown(dropDownHint: widget.questionText, listitems: widget.options, 
                              currentValue: 0, mark: 'mark', givenModelType: Options, 
                              margint: 5, marginb: 5, marginr: 20, marginl: 20, questionID: widget.questionID,
                              answerIndex: widget.questionIndex);
                        // MyRadioBtn(w: 1, title: widget.questionText, optionItems: widget.options,
                        //             questionID:  widget.questionID, questionIndex: widget.questionIndex,);        
      } 
  }
  @override
  Widget build(BuildContext context){
    return Container(
      child: categorization(widget.type?? 0) 
    );
  }
}