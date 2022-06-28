import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controllers/SurveyRelated/survey_creation_controller.dart';
import '../my_text.dart';

class QTypeDrop extends StatefulWidget {
  const QTypeDrop({Key? key, required this.dropDownHint,
  required this.listitems,
  required this.answerIndex, this.callBackFunction}) : super(key: key);
  final String? dropDownHint;
  final List<dynamic>? listitems;
  final int answerIndex;
  final Function? callBackFunction;
  @override
  _QTypeDropState createState() => _QTypeDropState();
}
class _QTypeDropState extends State<QTypeDrop> {
  final sCCont = Get.find<CreationCont>();
  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<String>> dropitems(List<dynamic> optionList){
       return optionList.map((item){
            return DropdownMenuItem(
             value: item.typeId.toString(),
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
          value: sCCont.qTypes[widget.answerIndex].value,
          onChanged: (String? newValue) {
            setState(() {
              sCCont.qTypes[widget.answerIndex].value = newValue.toString();
            });
            widget.callBackFunction!(newValue, widget.answerIndex);
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


