import 'package:flutter/material.dart';
import 'package:orh_user_app_version1/Controllers/SurveyRelated/survey_controller.dart';
import 'package:get/get.dart';
import 'package:orh_user_app_version1/Controllers/SurveyRelated/survey_creation_controller.dart';
import '../my_text.dart';

//auto survey vvsgeh vyd hereglegddeg drop
class AutocDrop extends StatefulWidget {
  const AutocDrop({Key? key, required this.dropDownHint,
  required this.listitems,required this.currentValue,this.questionID, required this.answerIndex}) : super(key: key);
  final String? dropDownHint;
  final List<dynamic>? listitems;
  final String? questionID;
  final int? currentValue;
  final int answerIndex;
  @override
  _AutocDropState createState() => _AutocDropState();
}
class _AutocDropState extends State<AutocDrop> {
  var sCont = Get.find<SCont>();
  var sCCont = Get.find<CreationCont>();
  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<String>> dropitems(List<dynamic> optionList){
       return optionList.map((item){
           return DropdownMenuItem(
             value: item.optionText.toString(),
             child: Text(item.optionText!),
             onTap: (){
              sCCont.strCombList[widget.answerIndex].unit = item.num.toString();
             },
             );
           }).toList();
    }
    return Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(15))
        ),
        margin: const EdgeInsets.only(left: 20, right: 20, 
                              top: 5, bottom: 5),
        padding: const EdgeInsets.only(left: 10, right: 0, top:5, bottom: 0),                      
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [ 
            myText(widget.dropDownHint!, 11, 1, FontWeight.bold),
            DropdownButton<String>(
          hint: myText(widget.dropDownHint?? '', 16, 1),
          value: sCont.dropvalueList[widget.answerIndex].value,
          onChanged: (String? newValue) {
            setState(() {
              sCont.dropvalueList[widget.answerIndex].value = newValue.toString();
            });
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


