import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orh_user_app_version1/Controllers/survey_controller.dart';
import 'package:orh_user_app_version1/MyWidgets/my_button.dart';
import 'package:orh_user_app_version1/MyWidgets/my_dropdown.dart';
import 'package:orh_user_app_version1/MyWidgets/my_text.dart';
import 'package:orh_user_app_version1/global_constant.dart';
import '../../Helpers/logging.dart';
import '../../Models/SurveyRelated/survey_creation_body.dart';



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
            switch(controller.newQuestionList[index].type){
              case '10': return toolUI(index); 
              default : return SurveyInputCreation(surveyQuestionIndex: index, textController: controller.textEditingControllers[index]);
            }
          },
        );
            },)
          ),
            Align(//hadaglah btn
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.only(bottom: 80),
              child: InkWell(
                onTap: (){
                  surveyController.surveyCreationbody.surveyName = surveyNametxtController.text;
                  surveyController.surveyCreationbody.questions = surveyController.newQuestionList; 
                  ereklog.wtf(jsonEncode(surveyController.surveyCreationbody.toJson()));
                  surveyController.backendtest();
                },
                child: myBtn(CommonColors.yellow, 200, 50, CommonColors.yellow, Colors.white, 'Судалгааг хадаглах'),
              ),
            ),
          ),
          Align(//hadaglah btn
            alignment: Alignment.bottomRight,
            child: Container(
              margin: const EdgeInsets.only(bottom: 80, right: 20),
              child: InkWell(
                onTap: (){
                  Get.defaultDialog(title: 'Tools', content: SizedBox(
                    child: Column(
                      children: [
                        myText('Доорх хэрэглэгдэхүүнүүдээс сонгон өөрийн судалгааны асуултанд нэмэх боломжтой', 15, 1),
                        InkWell(
                          onTap: (){
                            int i;
                            i = surveyController.newQuestionList.length;
                            surveyController.dropvalueList.insert(i,DropSelectVal());
                            surveyController.textEditingControllers.insert(i,TextEditingController());
                            surveyController.newQuestionList.insert(i, Question(type: '10', questionText: 'Регистрээ оруулах', options: []));
                          },
                          child: Container(
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black 
                            ),
                            borderRadius: const BorderRadius.all(Radius.circular(15)) 
                          ),
                          child: Column(
                            children: [
                              myText('РД аар иргэний мэдээлэл авах', 15, 1, (FontWeight.bold)),
                              myText('судлуулагчийн овог, нэр, утас, гэрийн хаягыг улсын бүргэлийн сангаас авах боломжтой', 15, 1)
                            ],
                          ),
                        ),
                        )
                      ],
                    ),
                  ),
                  actions: <Widget>[TextButton(onPressed: (){}, child: const Text("exit", style: TextStyle(fontSize: 20),)), 
                  ]);
                },
                child: myBtn(CommonColors.geregeBlue, 50, 50, CommonColors.geregeBlue, Colors.white, 'tools'),
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
    AnswerTypeOptions(id: 0, optionText: "Текст хэлбэрээр"),
    AnswerTypeOptions(id: 1, optionText: "Сонголт хэрбэрээр")
  ];

class SurveyInputCreation extends StatefulWidget {
  const SurveyInputCreation({ Key? key, required this.surveyQuestionIndex, required this.textController }) : super(key: key);
  final int surveyQuestionIndex;
  final TextEditingController textController;
  @override
  State<SurveyInputCreation> createState() => _SurveyInputCreationState();
}
class _SurveyInputCreationState extends State<SurveyInputCreation> {
  var surveyController = Get.find<SurveyController>();
  var ereklog = logger(SurveyInputCreation);
  callBackFunc(chosenVal){//drop down nii value nuudaas ali ni songogdson iig yalgah
    surveyController.newQuestionList[widget.surveyQuestionIndex].type = chosenVal;
    ereklog.wtf(chosenVal);
    if(surveyController.newQuestionList[widget.surveyQuestionIndex].options.isEmpty){
      if(surveyController.newQuestionList[widget.surveyQuestionIndex].containerHeight == null){
        surveyController.newQuestionList[widget.surveyQuestionIndex].containerHeight = 130;
      }
      if(chosenVal == '1'){
      setState(() {
        surveyController.newQuestionList[widget.surveyQuestionIndex].containerHeight = surveyController.newQuestionList[widget.surveyQuestionIndex].containerHeight! + 50;
        surveyController.newQuestionList[widget.surveyQuestionIndex].options.add(CreationOptions());
        surveyController.newQuestionList[widget.surveyQuestionIndex].optionTextController.add(TextEditingController());
      });
    }
    }
  }
  @override
  void initState() {
    super.initState();
    if(surveyController.newQuestionList[widget.surveyQuestionIndex].containerHeight == null){
      surveyController.newQuestionList[widget.surveyQuestionIndex].containerHeight = 130;
    } 
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
                   onChanged: (string){
                    surveyController.newQuestionList[widget.surveyQuestionIndex].questionText = string;
                   },
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
                          SizedBox(
                            width: 150,
                            child: TextField(
                              controller: surveyController.newQuestionList[widget.surveyQuestionIndex].optionTextController[index],
                              onChanged: (string){
                                surveyController.newQuestionList[widget.surveyQuestionIndex].options[index].optionText = string;
                              },
                              decoration: const InputDecoration(
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
                                surveyControllermini.newQuestionList[widget.surveyQuestionIndex].options.add(CreationOptions());
                                surveyControllermini.newQuestionList[widget.surveyQuestionIndex].optionTextController.add(TextEditingController());
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
        configureBtns(widget.surveyQuestionIndex)
      ],
    ),
  );
  }
}

Widget configureBtns(int index){
  var surveyController = Get.find<SurveyController>();
  return Column(
          children: [
             InkWell(// deeshee nemeh
               onTap: (){
                 if(surveyController.newQuestionList[index].type != null){
                   surveyController.dropvalueList.insert(index,DropSelectVal());
                   surveyController.textEditingControllers.insert(index,TextEditingController());
                   surveyController.newQuestionList.insert(index, Question(options: []));
                 }
                 else{
                    Get.snackbar('Талбаруудын утга хоосон байна', "Асуултын төрлийг сонгоно уу", snackPosition: SnackPosition.BOTTOM,
                       colorText: Colors.white, backgroundColor: Colors.grey[900], margin: const EdgeInsets.only(left: 5, right: 5, bottom: 80));
                 }
               },
               child: myBtn(CommonColors.yellow, 30, 30, CommonColors.yellow, Colors.grey, '\u{02C4}', 10, 25),
             ),
             InkWell(
               onTap: (){
                 surveyController.newQuestionList.removeAt(index);
                 surveyController.textEditingControllers.removeAt(index);
                 surveyController.dropvalueList.removeAt(index);
               },
               child: myBtn(CommonColors.yellow, 30, 30, CommonColors.yellow, Colors.grey, 'DEL', 10, 12),
             ),
             InkWell(// dooshoo nemeh
               onTap: (){
                 if(surveyController.newQuestionList[index].type != null){
                   int i = index+1;
                   surveyController.dropvalueList.insert(i,DropSelectVal());
                   surveyController.textEditingControllers.insert(i,TextEditingController());
                   surveyController.newQuestionList.insert(i, Question(options: []));
                 }
                 else{
                   Get.snackbar('Талбаруудын утга хоосон байна', "Асуултын төрлийг сонгоно уу", snackPosition: SnackPosition.BOTTOM,
                       colorText: Colors.white, backgroundColor: Colors.grey[900], margin: const EdgeInsets.only(left: 5, right: 5, bottom: 80));
                 }
               },
               child: myBtn(CommonColors.yellow, 30, 30, CommonColors.yellow, Colors.grey, '\u{02C5}', 10, 25),
             )
          ],
        );
}
Widget toolUI(int surveyQuestionIndex){
  return Row(
      mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        width: GeneralMeasurements.deviceWidth*.75,
        decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: Colors.white
        ),
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(10),
        child:  myText('Регистрийн дугаараар иргэний мэдээлэл авах', 15, 1),
        ),
      configureBtns(surveyQuestionIndex)          
    ],
  );
}