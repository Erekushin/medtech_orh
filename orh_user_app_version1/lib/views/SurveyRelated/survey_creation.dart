import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orh_user_app_version1/Controllers/survey_controller.dart';
import 'package:orh_user_app_version1/MyWidgets/my_button.dart';
import 'package:orh_user_app_version1/MyWidgets/my_dropdown.dart';
import 'package:orh_user_app_version1/global_constant.dart';
import '../../Helpers/logging.dart';
import '../../Models/SurveyRelated/survey_creationBody.dart';



class SurveyCreation extends StatefulWidget {
  const SurveyCreation({ Key? key }) : super(key: key);

  @override
  State<SurveyCreation> createState() => _SurveyCreationState();
}
class _SurveyCreationState extends State<SurveyCreation> {
  var ereklog = logger(SurveyCreation);
  var surveyNametxtController = TextEditingController();
  @override
  void initState() {
    super.initState();
    surveyController.surveyCreationbody.questions = List<Question>.generate(1, ((index) => Question(questionText: 'fdfdfd', options: []))).obs;
    surveyController.textEditingControllers.add(TextEditingController());
    surveyController.dropvalueList.add(DropSelectVal());
    surveyController.newQuestionList.add(Question(options: []));
  }
  var surveyController = Get.find<SurveyController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            margin: const EdgeInsets.all(30),
            padding: const EdgeInsets.all(5),
            child: TextField(
              controller: surveyNametxtController,
              decoration: const InputDecoration(
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
            return surveyInputCreation(surveyQuestionIndex: index, textController: controller.textEditingControllers[index]);
          },
        );
            },)
          ),
            Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.only(bottom: 80),
              child: InkWell(
                onTap: (){
                  int lastElement =  surveyController.newQuestionList.length - 1;
                  surveyController.newQuestionList.insert(lastElement, Question(questionText: surveyController.textEditingControllers[lastElement].text, type: surveyController.dropvalueList[lastElement].value, options: []));
                  surveyController.newQuestionList.removeLast();
                  surveyController.surveyCreationbody.surveyName = surveyNametxtController.text;
                  surveyController.surveyCreationbody.questions = surveyController.newQuestionList; 
                  ereklog.wtf(jsonEncode(surveyController.surveyCreationbody.toJson()));
                  // for(int i = 0; i< surveyController.textEditingControllers.length; i++){
                  //   ereklog.wtf(surveyController.textEditingControllers[i].text);
                  // }
                  // print('.........');
                  // for(int i = 0; i< surveyController.newQuestionList.length; i++){
                  //   ereklog.wtf(surveyController.newQuestionList[i].questionText);
                  // }
                  surveyController.surveyCreationPush();
                },
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

class surveyInputCreation extends StatefulWidget {
  const surveyInputCreation({ Key? key, required this.surveyQuestionIndex, required this.textController }) : super(key: key);
  final int surveyQuestionIndex;
  final TextEditingController textController;
  @override
  State<surveyInputCreation> createState() => _surveyInputCreationState();
}
class _surveyInputCreationState extends State<surveyInputCreation> {
  var surveyController = Get.find<SurveyController>();
  
  callBackFunc(chosenVal){
    if(chosenVal == '2'){
      setState(() {
        surveyController.newQuestionList[widget.surveyQuestionIndex].containerHeight = surveyController.newQuestionList[widget.surveyQuestionIndex].containerHeight! + 50;
        surveyController.newQuestionList[widget.surveyQuestionIndex].options.insert(0, CreationOptions(optionText: 'dsd'));
      });
    }
  }
  @override
  void initState() {
    super.initState();
    surveyController.newQuestionList[widget.surveyQuestionIndex].containerHeight = 130;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        
        Container(
          margin: const EdgeInsets.all(5),
          width: GeneralMeasurements.deviceWidth*.75,
          height: surveyController.newQuestionList[widget.surveyQuestionIndex].containerHeight,
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
                  controller: widget.textController,
                  decoration: const InputDecoration(
                    disabledBorder: InputBorder.none,
                    hintText: 'Асуултыг бичих',
                     enabledBorder: InputBorder.none,
                     focusedBorder: InputBorder.none
                  ),
                ),
                ),
                MyDropdown(dropDownHint: 'Асуултын төрлийг сонгох', listitems: list, currentValue: 0, mark: '', 
                           givenModelType: AnswerTypeOptions, margint: 5, marginb: 5, marginr: 5, marginl: 5, 
                           answerIndex: widget.surveyQuestionIndex, callBackFunction: callBackFunc,),
                Container(//option container
                  margin: const EdgeInsets.only(left: 50),
                  child: Expanded(
                    child: GetX<SurveyController>(
                      builder: (surveyControllermini){
                        return ListView.builder(
                    shrinkWrap: true,
                    itemCount: surveyControllermini.newQuestionList[widget.surveyQuestionIndex].options.length,
                    itemBuilder: (context, index){
                      return Row(
                        children: [
                          const SizedBox(
                            width: 150,
                            child: TextField(
                              decoration: InputDecoration(
                                   disabledBorder: InputBorder.none,
                                   hintText: 'сонголт нэмэх',
                                   enabledBorder: InputBorder.none,
                                   focusedBorder: InputBorder.none
                  ),
                            ),
                          ),
                          IconButton(
                            onPressed: (){
                              setState(() {
                                surveyControllermini.newQuestionList[widget.surveyQuestionIndex].options.insert(0, CreationOptions(optionText: 'dsd'));
                                surveyController.newQuestionList[widget.surveyQuestionIndex].containerHeight = surveyController.newQuestionList[widget.surveyQuestionIndex].containerHeight! + 50;
                              });
                            }, 
                            icon: const Icon(Icons.add)
                            )
                        ],
                      );
                    }
                    );
                      }
                      ),
                  ),
                )
                ],
            )
        ),
        Column(
          children: [
             InkWell(
               onTap: (){
                 surveyController.dropvalueList.insert(widget.surveyQuestionIndex,DropSelectVal());
                 surveyController.textEditingControllers.insert(widget.surveyQuestionIndex,TextEditingController());
                 surveyController.newQuestionList.insert(widget.surveyQuestionIndex, Question(questionText: surveyController.textEditingControllers[widget.surveyQuestionIndex].text, type: surveyController.dropvalueList[widget.surveyQuestionIndex].value, options: []));
               },
               child: myBtn(CommonColors.yellow, 30, 30, CommonColors.yellow, Colors.grey, '\u{02C4}', 10, 25),
             ),
             myBtn(CommonColors.yellow, 30, 30, CommonColors.yellow, Colors.grey, 'DEL', 10, 12),
             InkWell(
               onTap: (){
                 int i = widget.surveyQuestionIndex+1;
                 surveyController.dropvalueList.insert(i,DropSelectVal());
                 surveyController.textEditingControllers.insert(i,TextEditingController());
                 var a = surveyController.dropvalueList[widget.surveyQuestionIndex].value;
                surveyController.newQuestionList[widget.surveyQuestionIndex] = 
                Question(
                questionText: widget.textController.text,  
                type: a, 
                options: surveyController.newQuestionList[widget.surveyQuestionIndex].options
                );
                surveyController.newQuestionList.insert(i, Question(options: []));

                
               },
               child: myBtn(CommonColors.yellow, 30, 30, CommonColors.yellow, Colors.grey, '\u{02C5}', 10, 25),
             )
          ],
        )
      ],
    ),
  );
  }
}