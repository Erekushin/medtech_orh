import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orh_user_app_version1/MyWidgets/my_text.dart';
import 'package:orh_user_app_version1/global_constant.dart';
import '../Controllers/SurveyRelated/survey_controller.dart';
class MyRadioBtn extends StatefulWidget {
  MyRadioBtn({ Key? key,required this.w, this.optionItems, required this.title, 
                     required this.questionID, required this.questionIndex}) : super(key: key);
  final double w;
  final List? optionItems;
  final String title;
  final int questionID;
  final int questionIndex;
  static int? a;
  @override
  State<MyRadioBtn> createState() => _MyRadioBtn();
}
class _MyRadioBtn extends State<MyRadioBtn>{
  final queryController = Get.find<SurveyController>();
  int valueGroup = 44;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10, top: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            myText(widget.title, AllSizes.queryTxtSize, 1),
            
            // ListView.builder(
            //   shrinkWrap: true,
            //   itemCount: widget.optionItems!.length,
            //   itemBuilder: (context, index){
            //   // final eachOptionInfo = queryController.survey.result!.questions![widget.questionIndex].options![index];
            //   return RadioUnit(unitId: eachOptionInfo.optionId!, unitText: eachOptionInfo.optionText!,questionIndex: widget.questionIndex, radioIndex: index,);
            // })
      ],
    )
    );
  }
}

class RadioUnit extends StatefulWidget {
  RadioUnit({ Key? key, required this.unitId, required this.unitText,required this.questionIndex, required this.radioIndex}) : super(key: key);
  final int unitId;
  final String unitText;
  final int questionIndex;
  final int radioIndex;
  @override
  State<RadioUnit> createState() => _RadioUnitState();
}

class _RadioUnitState extends State<RadioUnit> {
  final queryController = Get.find<SurveyController>();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
          height: 35,
          child: ListTile(
                  dense: true,
                  title: myText(widget.unitText, AllSizes.queryTxtSize, 1),
                  selected: true,
                  leading: Radio<int>(
                    onChanged: (value){
                      setState(() {
                         MyRadioBtn.a = value;
                         queryController.surveyAnswer.answers![widget.questionIndex].optionId = value;
                      });
                    },
                    groupValue: MyRadioBtn.a,
                    value: widget.unitId,
                  ),
                ),
  );
  }
}


