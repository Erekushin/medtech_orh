import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orh_user_app_version1/Controllers/survey_controller.dart';
import 'package:orh_user_app_version1/MyWidgets/my_button.dart';
import 'package:orh_user_app_version1/MyWidgets/my_dropdown.dart';
import 'package:orh_user_app_version1/global_constant.dart';

import '../../models/childHeartQueryRelated/childheartquey.dart';
class SurveyCreation extends StatefulWidget {
  const SurveyCreation({ Key? key }) : super(key: key);

  @override
  State<SurveyCreation> createState() => _SurveyCreationState();
}

class _SurveyCreationState extends State<SurveyCreation> {
  var surveyController = Get.find<SurveyController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            margin: const EdgeInsets.all(30),
            padding: const EdgeInsets.all(5),
            child: const TextField(
              decoration: InputDecoration(
                hintText: 'Судалгааны нэрийг оруулах'
              ),
            ),
          ),
          Container(
            color: Colors.grey.withOpacity(0.5),
            margin: const EdgeInsets.only(top: 80, bottom: 140),
            child: GetX<SurveyController>(builder: (controller){
              return ListView.builder(
          itemCount: controller.newQuestionList.length,
          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          itemBuilder: (BuildContext context, int index){
            controller.dropvalueList.add(DropSelectVal());
            controller.textEditingControllers.add(TextEditingController());
            var item = controller.newQuestionList[index];
            return surveyInputCreation(index, controller.textEditingControllers[index]);
          },
        );
            },)
          ),
            Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.only(bottom: 80),
              child: InkWell(
                onTap: (){},
                child: myBtn(CommonColors.yellow, 200, 50, CommonColors.yellow, Colors.white, 'Судалгааг хадаглах'),
              ),
            ),
          )
        ],
      )
    );
  }
}

class AnswerTypeOptions {
  int? id;
  String? optionText;

  AnswerTypeOptions({this.id, this.optionText});
}
List<AnswerTypeOptions>? list = [
    AnswerTypeOptions(id: 1, optionText: "Текст хэлбэрээр"),
    AnswerTypeOptions(id: 2, optionText: "Сонголт хэрбэрээр")
  ];
Widget surveyInputCreation(int surveyQuestionIndex, TextEditingController textController){
  var surveyController = Get.find<SurveyController>();
  return SizedBox(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        
        Container(
          margin: const EdgeInsets.all(5),
          width: GeneralMeasurements.deviceWidth*.75,
          height: 130,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            color: Colors.white
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: TextField(
                controller: textController,
                decoration: const InputDecoration(
                  disabledBorder: InputBorder.none,
                  hintText: 'Асуултыг бичих',
                   enabledBorder: InputBorder.none,
                   focusedBorder: InputBorder.none
                ),
              ),
              ),
              MyDropdown(dropDownHint: 'Асуултын төрлийг сонгох', listitems: list, currentValue: 0, mark: '', givenModelType: AnswerTypeOptions, margint: 5, marginb: 5, marginr: 5, marginl: 5, answerIndex: surveyQuestionIndex)
              ],
          ),
        ),
        Column(
          children: [
             InkWell(
               onTap: (){
                 surveyController.newQuestionList.insert(surveyQuestionIndex, '544544545');
               },
               child: myBtn(CommonColors.yellow, 30, 30, CommonColors.yellow, Colors.grey, '\u{02C4}', 10, 25),
             ),
             myBtn(CommonColors.yellow, 30, 30, CommonColors.yellow, Colors.grey, 'DEL', 10, 12),
             InkWell(
               onTap: (){
                 int i = surveyQuestionIndex+1;
                 surveyController.newQuestionList.insert(i, '');
               },
               child: myBtn(CommonColors.yellow, 30, 30, CommonColors.yellow, Colors.grey, '\u{02C5}', 10, 25),
             )
          ],
        )
      ],
    ),
  );
}