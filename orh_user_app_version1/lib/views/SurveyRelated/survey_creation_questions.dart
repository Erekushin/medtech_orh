import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orh_user_app_version1/Controllers/SurveyRelated/survey_controller.dart';
import 'package:orh_user_app_version1/MyWidgets/my_button.dart';
import 'package:orh_user_app_version1/MyWidgets/my_text.dart';
import 'package:orh_user_app_version1/global_constant.dart';
import '../../Controllers/SurveyRelated/survey_creation_controller.dart';
import '../../Helpers/logging.dart';
import '../../Models/SurveyRelated/survey_creation_body.dart';
import '../../Models/SurveyRelated/survey_creation_types.dart';
import '../../MyWidgets/drop2.dart';
import '../../MyWidgets/my_dropdown.dart';
import '../../global_helpers.dart';
class SurveyCreationQuestion extends StatefulWidget {
  const SurveyCreationQuestion({ Key? key }) : super(key: key);

  @override
  State<SurveyCreationQuestion> createState() => _SurveyCreationQuestionState();
}
class _SurveyCreationQuestionState extends State<SurveyCreationQuestion> {
  var ereklog = logger(SurveyCreationQuestion);
  var surveyController = Get.find<SurveyController>();
  var sCreCont = Get.find<CreationCont>();
  @override
  void initState() {
    super.initState();
    if(sCreCont.newQuestionList.isEmpty){
       sCreCont.surveyCreationbody.questions = List<Question>.generate(1, ((index) => Question(questionText: 'fdfdfd', options: []))).obs;
       sCreCont.qTxts.add(TextEditingController());
       sCreCont.qTypes.add(DropSelectVal());
       sCreCont.staTypes.add(DropSelectVal());
       sCreCont.newQuestionList.add(Question(options: []));
    }
  }
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.white,
            margin: const EdgeInsets.only(bottom: 80),
            child: GetX<CreationCont>(builder: (controller){
              return ListView.builder(
          itemCount: controller.newQuestionList.length,
          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          itemBuilder: (BuildContext context, int index){
            switch(controller.newQuestionList[index].type){
              case '10': return toolUI(index); 
              default : return SurveyInputCreation(surveyQuestionIndex: index, textController: sCreCont.qTxts[index]);
            }
          },
        );
            },)
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GetX<CreationCont>(
                  builder: (surveyCreationCont){
                    return Container(
                  padding: const EdgeInsets.all(5),
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: const BorderRadius.all(Radius.circular(15))
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          myText('Нийт асуулт: ', 12, 1, (FontWeight.bold)),
                          myText(surveyCreationCont.newQuestionList.length.toString(), 12, 1, (FontWeight.bold)),
                        ],
                      ),
                      Row(
                        children: [
                          myText('tool асуулт: ', 12, 1, (FontWeight.bold)),
                          myText(surveyCreationCont.toolQuestionCount.toString(), 12, 1, (FontWeight.bold)),
                        ],
                      ),
                      
                    ],
                  ),
                );
                  }
                  ),
                Container(
              margin: const EdgeInsets.all(10),
              child: InkWell(
                    onTap: (){
                      Get.defaultDialog(title: 'Tools', content: SizedBox(
                        child: Column(
                          children: [
                            myText('Доорх хэрэглэгдэхүүнүүдээс сонгон өөрийн судалгааны асуултанд нэмэх боломжтой', 15, 1),
                            InkWell(
                              onTap: (){
                                int i;
                                i = sCreCont.newQuestionList.length;
                                sCreCont.qTypes.insert(i,DropSelectVal());
                                sCreCont.staTypes.insert(i, DropSelectVal());
                                sCreCont.qTxts.insert(i,TextEditingController());
                                sCreCont.newQuestionList.insert(i, Question(type: '10', questionText: 'Регистрээ оруулах', options: []));
                                sCreCont.toolQuestionCount += 1; 
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
                    child: myBtn(CommonColors.yellow, 80, 50, CommonColors.yellow, CommonColors.geregeBlue, 'tools'),
                  ),
            )
              ],
            ),
          ),
        ],
      )
    );
  }
}

class SurveyInputCreation extends StatefulWidget {
  const SurveyInputCreation({ Key? key, required this.surveyQuestionIndex, required this.textController }) : super(key: key);
  final int surveyQuestionIndex;
  final TextEditingController textController;
  @override
  State<SurveyInputCreation> createState() => _SurveyInputCreationState();
}
class _SurveyInputCreationState extends State<SurveyInputCreation> {
  var surveyCreationController = Get.find<CreationCont>();
  var surveyController = Get.find<SurveyController>();
  var ereklog = logger(SurveyInputCreation);
  callBackFunc(chosenVal){//drop down nii value nuudaas ali ni songogdson iig yalgah
    surveyCreationController.newQuestionList[widget.surveyQuestionIndex].type = chosenVal;
    ereklog.wtf(chosenVal);
    switch(chosenVal){
       case '8':
        setState(() {
        surveyCreationController.newQuestionList[widget.surveyQuestionIndex].options.clear();
        surveyCreationController.newQuestionList[widget.surveyQuestionIndex].optionTextController.clear();
        surveyCreationController.newQuestionList[widget.surveyQuestionIndex].containerHeight = 210;
      });
        
        break;
        case '7':
        if(surveyCreationController.newQuestionList[widget.surveyQuestionIndex].options.isEmpty){
      if(surveyCreationController.newQuestionList[widget.surveyQuestionIndex].containerHeight == 210){
        setState(() {
        surveyCreationController.newQuestionList[widget.surveyQuestionIndex].containerHeight = surveyCreationController.newQuestionList[widget.surveyQuestionIndex].containerHeight! + 50;
        surveyCreationController.newQuestionList[widget.surveyQuestionIndex].options.add(CreationOptions());
        surveyCreationController.newQuestionList[widget.surveyQuestionIndex].optionTextController.add(TextEditingController());
      });
      }
    }
        break;
        case '6':
        setState(() {
        surveyCreationController.newQuestionList[widget.surveyQuestionIndex].options.clear();
        surveyCreationController.newQuestionList[widget.surveyQuestionIndex].optionTextController.clear();
        surveyCreationController.newQuestionList[widget.surveyQuestionIndex].containerHeight = 210;
      }); 
        
        break;
      }
  }
  @override
  void initState() {
    super.initState();
    if(surveyCreationController.newQuestionList[widget.surveyQuestionIndex].containerHeight == null){
      surveyCreationController.newQuestionList[widget.surveyQuestionIndex].containerHeight = 210;
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
          height: surveyCreationController.newQuestionList[widget.surveyQuestionIndex].containerHeight,
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
                    surveyCreationController.newQuestionList[widget.surveyQuestionIndex].questionText = string;
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
                MyDropdown(dropDownHint: 'Асуултын төрлийг сонгох', listitems: surveyCreationController.surveyCreationTypes.result!.questionType!, currentValue: 0, mark: '', 
                           givenModelType: TypeInfo, margint: 5, marginb: 5, marginr: 5, marginl: 5, 
                           answerIndex: widget.surveyQuestionIndex, callBackFunction: callBackFunc,),
                Drop2(dropDownHint: 'Статистик үзүүлэлт нэмэх', listitems: surveyCreationController.surveyCreationTypes.result!.statistic!, currentValue: 0, mark: '', 
                           givenModelType: TypeInfo, margint: 5, marginb: 5, marginr: 5, marginl: 5, 
                           answerIndex: widget.surveyQuestionIndex, callBackFunction: (){},),           
                                       
                Container(//option container
                  margin: const EdgeInsets.only(left: 50),
                  child: Expanded(
                    child: GetX<CreationCont>(
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
                              controller: surveyCreationController.newQuestionList[widget.surveyQuestionIndex].optionTextController[index],
                              onChanged: (string){
                                surveyCreationController.newQuestionList[widget.surveyQuestionIndex].options[index].optionText = string;
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
                                surveyCreationController.newQuestionList[widget.surveyQuestionIndex].containerHeight = surveyCreationController.newQuestionList[widget.surveyQuestionIndex].containerHeight! + 50;
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
  var sCreCont = Get.find<CreationCont>();
  return Column(
          children: [
             InkWell(// deeshee nemeh
               onTap: (){
                 if(sCreCont.newQuestionList[index].type != null){
                   sCreCont.qTypes.insert(index,DropSelectVal());
                   sCreCont.staTypes.insert(index, DropSelectVal());
                   sCreCont.qTxts.insert(index,TextEditingController());
                   sCreCont.newQuestionList.insert(index, Question(options: []));
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
                 sCreCont.newQuestionList.removeAt(index);
                 sCreCont.qTxts.removeAt(index);
                 sCreCont.qTypes.removeAt(index);
                 sCreCont.staTypes.removeAt(index);
               },
               child: myBtn(CommonColors.yellow, 30, 30, CommonColors.yellow, Colors.grey, 'DEL', 10, 12),
             ),
             InkWell(// dooshoo nemeh
               onTap: (){
                 if(sCreCont.newQuestionList[index].type != null){
                   int i = index+1;
                   sCreCont.qTypes.insert(i,DropSelectVal());
                   sCreCont.staTypes.insert(i, DropSelectVal());
                   sCreCont.qTxts.insert(i,TextEditingController());
                   sCreCont.newQuestionList.insert(i, Question(options: []));
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

