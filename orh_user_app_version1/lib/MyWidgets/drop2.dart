import 'package:flutter/material.dart';
import 'package:orh_user_app_version1/Controllers/SurveyRelated/survey_controller.dart';
import 'package:orh_user_app_version1/views/SurveyRelated/survey_creation.dart';
import '../Controllers/SurveyRelated/survey_creation_controller.dart';
import '../Models/SurveyRelated/survey_creation_types.dart';
import '../models/SurveyRelated/survey_body.dart';
import 'my_text.dart';
import 'package:get/get.dart';


class Drop2 extends StatefulWidget {
  const Drop2({Key? key, required this.dropDownHint,
  required this.listitems,required this.currentValue, 
  required this.mark, required this.givenModelType, 
  required this.margint, required this.marginb, required this.marginr,
  required  this.marginl, this.questionID, required this.answerIndex, this.callBackFunction}) : super(key: key);
  final String? dropDownHint;
  final List<dynamic>? listitems;
  final String? questionID;
  final int? currentValue;
  final String? mark;
  final Type givenModelType;
  final double margint;
  final double marginb;
  final double marginr;
  final double marginl;
  final int answerIndex;
  final Function? callBackFunction;
  @override
  _Drop2State createState() => _Drop2State();
}
class _Drop2State extends State<Drop2> {
  final sCont = Get.find<SurveyController>();
  final sCreationCont = Get.find<CreationCont>();
  @override
  void initState() {
     switch(widget.givenModelType){
        case Options:
        sCont.surveyAnswer.answers![widget.answerIndex].questionId = int.parse(widget.questionID!) ;
        break;
        case TypeInfo:
           
      }
    // widget.listitems?.forEach((element) {
    //   if(element.id == widget.currentValue){
    //     selectval = element.name;
    //   }
    // });
    // queryController.dropvalueList[widget.answerIndex].value  =  null;
  }
  // String? selectval;
  int? SelectedID;
  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<String>> dropitems(List<dynamic> optionList){
      switch(widget.givenModelType){
        case Options:
         return optionList.map((item){
           return DropdownMenuItem(
             value: item.optionId.toString(),
             child: Text(item.optionText!),
             onTap: (){
               print(item.optionText);
               print(item.optionId);
               sCont.surveyAnswer.answers![widget.answerIndex].questionId = int.parse(widget.questionID!);
               sCont.surveyAnswer.answers![widget.answerIndex].optionId = item.optionId; 
             },
             );
           }).toList();
        case TypeInfo:
           return optionList.map((item){
            return DropdownMenuItem(
             value: item.keyWord.toString(),
             child: Text(item.typeName!),
             onTap: (){},
             );
           }).toList();
        default: return const [DropdownMenuItem(child: Text('Хоосон утга'))] ;   
      }
    }
    return Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(15))
        ),
        margin: EdgeInsets.only(left: widget.marginl, right: widget.marginr, 
                              top: widget.margint, bottom: widget.marginb),
        padding: const EdgeInsets.only(left: 10, right: 0, top:5, bottom: 0),                      
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [ 
            myText(widget.dropDownHint!, 11, 1, FontWeight.bold),
            DropdownButton<String>(
          hint: myText(widget.dropDownHint?? '', 16, 1),
          value: sCont.statisticTypeList[widget.answerIndex].value,
          onChanged: (String? newValue) {
            setState(() {
              print(newValue);
              sCont.statisticTypeList[widget.answerIndex].value = newValue.toString();
            });
            sCreationCont.newQuestionList[widget.answerIndex].statistic = newValue;
          },
          underline: const SizedBox(),
          isExpanded: true,
          borderRadius: BorderRadius.circular(5),
          items: dropitems(widget.listitems?? [])
        )
          ],
        ),
    );
  }
}


