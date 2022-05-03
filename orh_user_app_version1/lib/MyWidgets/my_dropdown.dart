import 'package:flutter/material.dart';
import 'package:orh_user_app_version1/Controllers/survey_controller.dart';
import '../models/SurveyRelated/surveyQuestionBody.dart';
import '../views/SurveyRelated/survey_creation.dart';
import 'my_text.dart';
import 'package:get/get.dart';


class MyDropdown extends StatefulWidget {
  MyDropdown({Key? key, required this.dropDownHint,
  required this.listitems,required this.currentValue, 
  required this.mark, required this.givenModelType, 
  required this.margint, required this.marginb, required this.marginr,
  required  this.marginl, this.questionID, required this.answerIndex}) : super(key: key);
  final String? dropDownHint;
  final List<dynamic>? listitems;
  final int? questionID;
  final int? currentValue;
  final String? mark;
  final Type givenModelType;
  final double margint;
  final double marginb;
  final double marginr;
  final double marginl;
  final int answerIndex;
  @override
  _MyDropDownState createState() => _MyDropDownState();
}
class _MyDropDownState extends State<MyDropdown> {
  final queryController = Get.find<SurveyController>();
  @override
  void initState() {
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
             value: item.id.toString(),
             child: Text(item.optionText!),
             onTap: (){
               queryController.queryAnswer.answers![widget.answerIndex].questionId = widget.questionID;
               queryController.queryAnswer.answers![widget.answerIndex].optionId = item.id; 
             },
             );
           }).toList();
        case AnswerTypeOptions:
           return optionList.map((item){
            return DropdownMenuItem(
             value: item.id.toString(),
             child: Text(item.optionText!),
             onTap: (){
              
             },
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
          value: queryController.dropvalueList[widget.answerIndex].value,
          onChanged: (String? newValue) {
            setState(() {
              queryController.dropvalueList[widget.answerIndex].value = newValue.toString();
            });
          },
          underline: const SizedBox(),
          isExpanded: true,
          borderRadius: BorderRadius.circular(5),
          items: dropitems(widget.listitems!)
        )
          ],
        ),
    );
  }
}


