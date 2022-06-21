import 'package:flutter/material.dart';
import 'package:orh_user_app_version1/Controllers/SurveyRelated/survey_controller.dart';
import 'package:get/get.dart';
import '../../Controllers/SurveyRelated/survey_creation_controller.dart';
import '../my_text.dart';


class QStaDrop extends StatefulWidget {
  const QStaDrop({Key? key, required this.dropDownHint,
  required this.listitems, required this.answerIndex, this.callBackFunction}) : super(key: key);
  final String? dropDownHint;
  final List<dynamic>? listitems;
  final int answerIndex;
  final Function? callBackFunction;
  @override
  _QStaDropState createState() => _QStaDropState();
}
class _QStaDropState extends State<QStaDrop> {
  final sCont = Get.find<SurveyController>();
  final sCCont = Get.find<CreationCont>();
  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<String>> dropitems(List<dynamic> optionList){
      return optionList.map((item){
            return DropdownMenuItem(
             value: item.keyWord.toString(),
             child: Text(item.typeName!),
             onTap: (){},
             );
           }).toList();
    }
    return Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(15))
        ),
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.only(left: 10, right: 0, top:5, bottom: 0),                      
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [ 
            myText(widget.dropDownHint!, 11, 1, FontWeight.bold),
            DropdownButton<String>(
          hint: myText(widget.dropDownHint?? '', 16, 1),
          value: sCCont.staTypes[widget.answerIndex].value,
          onChanged: (String? newValue) {
            if(sCCont.staTypes.length >= 5){
               Get.snackbar('Боломжгүй үйлдэл', 'Line chart ийн limit хэтэрсэн байна.', snackPosition: SnackPosition.BOTTOM,
               colorText: Colors.white, backgroundColor: Colors.grey[900], margin:  const EdgeInsets.all(5));
            }
            else{
               setState(() {
              sCCont.staTypes[widget.answerIndex].value = newValue.toString();
              });
              sCCont.newQuestionList[widget.answerIndex].statistic = newValue;
            }
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


