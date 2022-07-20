import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orh_user_app_version1/Controllers/SurveyRelated/survey_controller.dart';
import 'package:orh_user_app_version1/Controllers/SurveyRelated/survey_creation_controller.dart';
import 'package:orh_user_app_version1/MyWidgets/my_textfield.dart';
import 'package:orh_user_app_version1/MyWidgets/survey_related/autoc_drop.dart';
import 'package:orh_user_app_version1/MyWidgets/survey_related/message_txt.dart';
import 'package:orh_user_app_version1/MyWidgets/survey_related/option_drop.dart';
import 'package:orh_user_app_version1/MyWidgets/survey_tools/rd_xyr_info.dart';
import 'package:orh_user_app_version1/Models/SurveyRelated/survey_body.dart';
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
  var queryController = Get.find<SCont>();
  var sCCont = Get.find<CreationCont>();
  Widget categorization(int type){
    switch (type) {
        case 6:
          return MyTextField(hinttxt:widget.questionText, txtController:queryController.textEditingControllers[widget.questionIndex], margint: 5, marginb: 5, 
          marginr: 20, marginl: 20, questionID: widget.questionID, answerIndex: widget.questionIndex, mark: 'query'); 
        case 12:
        return MessageTxt(hintText: widget.questionText, questionID: widget.questionID, answerIndex: widget.questionIndex,);  
        case 7:  
        if(sCCont.sSwitcher.value){
          return AutocDrop(dropDownHint: widget.questionText, listitems: widget.options, 
                              currentValue: 0, questionID: widget.questionID,
                              answerIndex: widget.questionIndex);
        }
        else{
          return OptionDrop(dropDownHint: widget.questionText, listitems: widget.options, 
                              currentValue: 0, questionID: widget.questionID,
                              answerIndex: widget.questionIndex);
        }
        case 8: return MyTextField(hinttxt:widget.questionText, txtController:queryController.textEditingControllers[widget.questionIndex], margint: 5, marginb: 5, 
          marginr: 20, marginl: 20, questionID: widget.questionID, answerIndex: widget.questionIndex, mark: 'onlyNumber');
        case 10 : return rdXyrInfo(widget.questionText, widget.questionID, widget.questionIndex);
        default: return const Text('бүртгэгдээгүй төрөл');
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