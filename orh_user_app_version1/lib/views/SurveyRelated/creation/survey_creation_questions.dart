import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orh_user_app_version1/Controllers/SurveyRelated/survey_controller.dart';
import 'package:orh_user_app_version1/Models/SurveyRelated/survey_body.dart';
import 'package:orh_user_app_version1/MyWidgets/my_button.dart';
import 'package:orh_user_app_version1/MyWidgets/my_text.dart';
import 'package:orh_user_app_version1/global_constant.dart';
import '../../../Controllers/SurveyRelated/survey_creation_controller.dart';
import '../../../Helpers/logging.dart';
import '../../../Models/SurveyRelated/survey_creation_types.dart';
import '../../../MyWidgets/survey_related/q_sta_drop.dart';
import '../../../MyWidgets/survey_related/q_type_drop.dart';
import '../../../global_helpers.dart';
class SurveyCreationQuestion extends StatefulWidget {
  const SurveyCreationQuestion({ Key? key }) : super(key: key);

  @override
  State<SurveyCreationQuestion> createState() => _SurveyCreationQuestionState();
}
class _SurveyCreationQuestionState extends State<SurveyCreationQuestion> {
  var ereklog = logger(SurveyCreationQuestion);
  var surveyController = Get.find<SCont>();
  var sCreCont = Get.find<CreationCont>();

  List<TypeInfo>? questionType;
  List<TypeInfo>? statistics;

  @override
  void initState() {
    super.initState();
    int a = 5;
    int b = 10;
    a = b;
    b = 11;
    print(a.toString());


    var sCCont = Get.find<CreationCont>();

    questionType = sCCont.surveyCreationTypes.result!.questionType!;
    statistics = sCCont.surveyCreationTypes.result!.statistic!;
    if(sCreCont.newQuestionList.isEmpty){
       sCreCont.surveyCreationbody.questions = List<Questions>.generate(1, ((index) => 
       Questions(questionText: 'fdfdfd', 
                options: []))).obs;
       sCreCont.qTxts.add(TextEditingController());
       sCreCont.qTypes.add(DropSelectVal());
       sCreCont.staTypes.add(DropSelectVal());
       sCreCont.newQuestionList.add(Questions(options: [],
                statistics: statistics,
                questionType: questionType));
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
              case 10: return toolUI(index); 
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
                                sCreCont.newQuestionList.insert(i, Questions(type: 10, questionText: 'Регистрээ оруулах', options: []));
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
  var sCCont = Get.find<CreationCont>();
  var surveyController = Get.find<SCont>();
  var ereklog = logger(SurveyInputCreation);
  callBackFunc(int chosenVal, int index){//drop down nii value nuudaas ali ni songogdson iig yalgah
    sCCont.newQuestionList[widget.surveyQuestionIndex].type = chosenVal;
    ereklog.wtf(chosenVal);
    switch(chosenVal){
       case 8:
        setState((){
        sCCont.newQuestionList[widget.surveyQuestionIndex].options.clear();
        sCCont.newQuestionList[widget.surveyQuestionIndex].optionTextController.clear();
        sCCont.newQuestionList[widget.surveyQuestionIndex].containerHeight = 210;
        // sCCont.newQuestionList[widget.surveyQuestionIndex].statistics!.clear();
        // for(int a = 0; a < sCCont.surveyCreationTypes.result!.statistic!.length; a++){
        //   if(sCCont.surveyCreationTypes.result!.statistic![a].t_type == 'number'){
        //     sCCont.newQuestionList[widget.surveyQuestionIndex].statistics!.add(sCCont.surveyCreationTypes.result!.statistic![a]);
        //   }
        // } 
      });
        
        break;
        case 7:
        if(sCCont.newQuestionList[widget.surveyQuestionIndex].options.isEmpty){
      if(sCCont.newQuestionList[widget.surveyQuestionIndex].containerHeight == 210){
        setState(() {
        sCCont.newQuestionList[widget.surveyQuestionIndex].containerHeight = sCCont.newQuestionList[widget.surveyQuestionIndex].containerHeight! + 50;
        sCCont.newQuestionList[widget.surveyQuestionIndex].options.add(Options());
        sCCont.newQuestionList[widget.surveyQuestionIndex].optionTextController.add(TextEditingController());
        // sCCont.newQuestionList[widget.surveyQuestionIndex].statistics!.clear();
      });
      }
    }
        break;
        case 6:
        setState(() {
        sCCont.newQuestionList[widget.surveyQuestionIndex].options.clear();
        sCCont.newQuestionList[widget.surveyQuestionIndex].optionTextController.clear();
        sCCont.newQuestionList[widget.surveyQuestionIndex].containerHeight = 210;

        // sCCont.newQuestionList[widget.surveyQuestionIndex].statistics!.clear();
       
      }); 
        
        break;
      }
  }
  @override
  void initState() {
    super.initState();
    if(sCCont.newQuestionList[widget.surveyQuestionIndex].containerHeight == null){
      sCCont.newQuestionList[widget.surveyQuestionIndex].containerHeight = 210;
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
          height: sCCont.newQuestionList[widget.surveyQuestionIndex].containerHeight,
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
                    sCCont.newQuestionList[widget.surveyQuestionIndex].questionText = string;
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
                QStaDrop(dropDownHint: 'Статистик үзүүлэлт нэмэх', listitems: sCCont.newQuestionList[widget.surveyQuestionIndex].statistics!,
                           answerIndex: widget.surveyQuestionIndex, callBackFunction: (){},),
                QTypeDrop(dropDownHint: 'Асуултын төрлийг сонгох', listitems: sCCont.newQuestionList[widget.surveyQuestionIndex].questionType!,
                           answerIndex: widget.surveyQuestionIndex, callBackFunction: callBackFunc,),                
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
                              controller: sCCont.newQuestionList[widget.surveyQuestionIndex].optionTextController[index],
                              onChanged: (string){
                                sCCont.newQuestionList[widget.surveyQuestionIndex].options[index].optionText = string;
                              },
                              decoration: const InputDecoration(
                                   disabledBorder: InputBorder.none,
                                   hintText: 'сонголт нэмэх',
                                   enabledBorder: InputBorder.none,
                                   focusedBorder: InputBorder.none
                  ),
                            ),
                          ),
                             InkWell(
                              onTap: (){
                                  setState(() {
                                surveyControllermini.newQuestionList[widget.surveyQuestionIndex].options.add(Options());
                                surveyControllermini.newQuestionList[widget.surveyQuestionIndex].optionTextController.add(TextEditingController());
                                sCCont.newQuestionList[widget.surveyQuestionIndex].containerHeight = sCCont.newQuestionList[widget.surveyQuestionIndex].containerHeight! + 50;
                              });
                              },
                              child: const Icon(Icons.add),
                            ),
                            InkWell(
                              onTap: (){
                                  setState(() {
                                surveyControllermini.newQuestionList[widget.surveyQuestionIndex].options.removeAt(index);
                                surveyControllermini.newQuestionList[widget.surveyQuestionIndex].optionTextController.removeAt(index);
                                sCCont.newQuestionList[widget.surveyQuestionIndex].containerHeight = sCCont.newQuestionList[widget.surveyQuestionIndex].containerHeight! - 50;
                              });
                              },
                              child: const Icon(Icons.remove),
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
  var surveyController = Get.find<SCont>();
  var sCreCont = Get.find<CreationCont>();
  return Column(
          children: [
             InkWell(// deeshee nemeh
               onTap: (){
                 if(sCreCont.newQuestionList[index].type != null){
                   sCreCont.qTypes.insert(index,DropSelectVal());
                   sCreCont.staTypes.insert(index, DropSelectVal());
                   sCreCont.qTxts.insert(index,TextEditingController());
                   sCreCont.newQuestionList.insert(index, Questions(options: [],
                statistics: sCreCont.surveyCreationTypes.result!.statistic!,
                questionType: sCreCont.surveyCreationTypes.result!.questionType!));
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
                   sCreCont.newQuestionList.insert(i, Questions(options: [],
                   statistics: sCreCont.surveyCreationTypes.result!.statistic!,
                   questionType: sCreCont.surveyCreationTypes.result!.questionType!));
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

