import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orh_user_app_version1/Controllers/login_controller.dart';
import 'package:orh_user_app_version1/Controllers/survey_controller.dart';
import 'package:orh_user_app_version1/Controllers/setting_controller.dart';
import 'package:orh_user_app_version1/MyWidgets/my_button.dart';
import 'package:orh_user_app_version1/MyWidgets/my_dropdown.dart';
import 'package:orh_user_app_version1/MyWidgets/my_textfield.dart';
import 'package:orh_user_app_version1/global_constant.dart';
import 'package:orh_user_app_version1/global_helpers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orh_user_app_version1/models/SurveyRelated/survey_questionBody.dart';
import '../../MyWidgets/my_text.dart';
import '../../MyWidgets/my_textfield.dart';
import '../../global_constant.dart';
import '../../models/SurveyRelated/aimags.dart';


///Асуулгаас бүтсэн нэг бие сэдэв бүхий бүртгэлийн 
///болон судалгааны асуултуудыг олон хуудасанд хуваан харуулах.
class SurveyUnit extends StatefulWidget {
  const SurveyUnit({ Key? key }) : super(key: key);
  @override
  State<SurveyUnit> createState() => _SurveyUnit();
}
class _SurveyUnit extends State<SurveyUnit> {
  var pageController = PageController();
  final queryController = Get.find<SurveyController>();
  final settingsController = Get.find<SettingController>();
  @override
  void initState() {
    super.initState();
    GlobalHelpers.surveyPageCount = queryController.queryQuestions.result!.questions!.length~/AllSizes.pageQuestionCount+1;
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: PageView.builder(
              controller: pageController,
              onPageChanged: (index){
                switch(index){
                  case 1:
                    if(settingsController.xyrServiceSwitcher.value){
                     queryController.xyrInfoGet();
                    }
                  break;
                }
              },
              itemCount: GlobalHelpers.surveyPageCount,
              itemBuilder: (context, index){
                return PageUnit(pageIndex: index,);
              }
              ),
      )
      );
  }
}


///судалгааны асуултуудыг харуулах хуудас
class PageUnit extends StatefulWidget {
  const PageUnit({ Key? key,required this.pageIndex }) : super(key: key);
  final int pageIndex;
  @override
  State<PageUnit> createState() => _PageUnitState();
}
class _PageUnitState extends State<PageUnit> {
  String? aimagSelectVal;
  String? sumSelectVal;
  bool infoContainerSwitch = false;
  var settingsControllerOut = Get.find<SettingController>();
  var surveyControllerOut = Get.find<SurveyController>(); 
  void pushData(){
    surveyControllerOut.pushDataBtn.value = false;
    if(surveyControllerOut.haveDefaultData.value){//default aa shalgaad 
                            surveyControllerOut.queryAnswer.researcherGeregeID = Get.find<LoginController>().geregeUser.result!.id;
                            surveyControllerOut.queryAnswer.aimagCode = surveyControllerOut.researcherDefaultData.result!.aimagCode; 
                            surveyControllerOut.queryAnswer.aimagName = surveyControllerOut.researcherDefaultData.result!.aimagName;
                            surveyControllerOut.queryAnswer.sumCode = surveyControllerOut.researcherDefaultData.result!.sumCode;
                            surveyControllerOut.queryAnswer.sumName = surveyControllerOut.researcherDefaultData.result!.sumName;
                            surveyControllerOut.queryAnswer.regNo = surveyControllerOut.rdTxtController.text;
                            surveyControllerOut.queryAnswer .surveyId = '4'; // saijruulna
                        if(settingsControllerOut.xyrServiceSwitcher.value){//xyr aa asaasan vgvvgee shalgaad 
                          if(GlobalHelpers.isXyrNull){
                             try{
                              surveyControllerOut.queryAnswer.gender = surveyControllerOut.xyrInfo.result!.gender.toString();
                              surveyControllerOut.queryAnswer.age = surveyControllerOut.xyrInfo.result!.age;
                              surveyControllerOut.queryAnswer.fistName = surveyControllerOut.xyrInfo.result!.firstName;
                              surveyControllerOut.queryAnswer.lastName = surveyControllerOut.xyrInfo.result!.lastName;
                              surveyControllerOut.surveyAnswersPush();
                              print('huraa avsan');
                            }
                            catch(e){
                               Get.snackbar('Алдаа', '$e!', snackPosition: SnackPosition.BOTTOM,
                               colorText: Colors.white, backgroundColor: Colors.grey[900], margin:  const EdgeInsets.all(5));
                            }
                            }
                          else{
                                Get.snackbar('Талбарын мэдээлэл дутуу байна', 'Судалгаанд оролцогчийн Регистрийн дугаарыг оруулна уу!', snackPosition: SnackPosition.BOTTOM,
                                colorText: Colors.white, backgroundColor: Colors.grey[900], margin:  const EdgeInsets.all(5));
                          }
                        }
                        else{
                          if(surveyControllerOut.gender.text != '' && surveyControllerOut.age.text != ''&&
                             surveyControllerOut.firstName.text != '' && surveyControllerOut.lastName.text != '' && 
                             surveyControllerOut.rdTxtController.text != ''){
                             try{
                                surveyControllerOut.queryAnswer.gender = surveyControllerOut.gender.text;
                                surveyControllerOut.queryAnswer.age = surveyControllerOut.age.text;
                                surveyControllerOut.queryAnswer.fistName = surveyControllerOut.firstName.text;
                                surveyControllerOut.queryAnswer.lastName = surveyControllerOut.lastName.text;
                                surveyControllerOut.surveyAnswersPush();
                                print('garaas medeelel oruulchaad yavuulah gej bna');
                            }
                            catch(e){
                               Get.snackbar('Алдаа', '$e!', snackPosition: SnackPosition.BOTTOM,
                               colorText: Colors.white, backgroundColor: Colors.grey[900], margin:  const EdgeInsets.all(5));
                            }
                        
                        }
                        else{
                           surveyControllerOut.queryAnswer.researcherGeregeID = '';
                           surveyControllerOut.queryAnswer.regNo = '';
                            surveyControllerOut.queryAnswer.aimagCode = ''; 
                            surveyControllerOut.queryAnswer.aimagName = '';
                            surveyControllerOut.queryAnswer.sumCode = '';
                            surveyControllerOut.queryAnswer.sumName = '';
                            surveyControllerOut.queryAnswer .surveyId = '4'; // saijruulna
                          Get.snackbar('Талбарын мэдээлэл дутуу байна', 'Судалгаанд оролцогчийн мэдээллийг оруулна уу!', snackPosition: SnackPosition.BOTTOM,
                                colorText: Colors.white, backgroundColor: Colors.grey[900], margin:  const EdgeInsets.all(5));
                        }
                          
                        }
                      }
                      else{
                        Get.snackbar('Талбарын мэдээлэл дутуу байна', 'Судалгааг авч буй байршилын мэдээллийг оруулна уу!', snackPosition: SnackPosition.BOTTOM,
                                colorText: Colors.white, backgroundColor: Colors.grey[900], margin:  const EdgeInsets.all(5));
                      }
                       
  }
  List<DropdownMenuItem<String>> aimagItems(List<Aimags> aimagList){
    return aimagList.map((item){
            return DropdownMenuItem(
                onTap: (){
                  Get.find<SurveyController>().researcherDefaultData.result!.aimagCode = item.aimagCode!;
                  Get.find<SurveyController>().researcherDefaultData.result!.aimagName = item.aimagName!;
                  Get.find<SurveyController>().chosenAimag.value = aimagList.indexOf(item);
                },
                value: item.aimagName,
                child: Text(item.aimagName!)
            );
          }).toList();
  }
  List<DropdownMenuItem<String>> sumItems(List<Sums> sumList){
    return sumList.map((item){
            return DropdownMenuItem(
                onTap: (){
                  Get.find<SurveyController>().researcherDefaultData.result!.sumCode = item.sumCode!;
                  Get.find<SurveyController>().researcherDefaultData.result!.sumName = item.sumName!;
                },
                value: item.sumName,
                child: Text(item.sumName!)
            );
          }).toList();
  }

  @override
  // void dispose() {
  //   super.dispose();
  //    for (TextEditingController textEditingController in controllerList) {
  //     textEditingController.dispose();
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        GlobalHelpers.bottomnavbarSwitcher.add(true);
        return true;
      },
      child: Stack(
        children: [
          SingleChildScrollView(
        child: Column(
                children: [
                   widget.pageIndex == 0? Container(
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(15)),
                            color: Colors.grey.withOpacity(.2)
                          ),
                          child: Stack(
                            children: [
                              Visibility(//small one
                                visible: infoContainerSwitch? false : true,
                                child: InkWell(
                                  onTap: (){
                                     setState(() {
                                    infoContainerSwitch = true;
                                  });
                                  },
                                  child: Row(
                                  children: [
                                    SizedBox(
                                      width: GeneralMeasurements.deviceWidth*.7,
                                      child: RichText(
                                        maxLines: 4,
                                        text: TextSpan(
                                        style: GoogleFonts.openSans(height: 1, fontWeight: FontWeight.w600, fontSize: 15, color: Colors.black.withOpacity(.5)),
                                        children: [
                                          // TextSpan(text: surveyControllerOut.researcherDefaultData.result!.currentDate?? ""),
                                          // const TextSpan(text: ' '),
                                          // TextSpan(text: surveyControllerOut.researcherDefaultData.result!.aimagName?? " "),
                                          // const TextSpan(text: ' '),
                                          // TextSpan(text: surveyControllerOut.researcherDefaultData.result!.sumName?? " "),
                                        ]
                                      )),
                                    ),
                                  ],
                                ),
                                ),
                              ),
                              Visibility(//big one
                                visible: infoContainerSwitch? true : false,
                                child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                       myText('Судалгаа хийсэн огноо:', 16, 1.5),
                                       GetX<SurveyController>(builder: (surveyController){
                                         return  InkWell(
                                           onTap: (){
                                             setState(() {
                                           if(surveyController.greenCheckIcon.value){
                                              infoContainerSwitch = false;
                                              surveyController.greenCheckIcon.value = false;
                                              surveyController.researcherDefaultData.result!.userId = Get.find<LoginController>().geregeUser.result!.id;
                                              surveyController.researcherDefaultDataUpdateAndPush();
                                           }
                                         });
                                           },
                                           child: Icon(
                                         Icons.check_circle,
                                         color: surveyController.greenCheckIcon.value? Colors.green : Colors.grey,
                                         ),
                                         );
    
                                       })
                                    ],
                                  ),                
                                 
                                  myText(surveyControllerOut.currentDate.toString().substring(0,10), 16, 1.5),
                                  Container(
                                    padding: const EdgeInsets.only(left: 0, right: 0, top: 10, bottom: 0),
                                    child: DropdownButton<String>(
                                      hint: myText(surveyControllerOut.researcherDefaultData.result!.aimagName?? 'Аймаг, хотын нэр?', 16, 2),
                                      value: aimagSelectVal,
                                      onChanged: (String? newValue){
                                        setState(() {
                                          aimagSelectVal = newValue.toString();
                                          sumSelectVal = null;
                                        });
                                      },
                                      underline: const SizedBox(),
                                      isExpanded: true,
                                      borderRadius: BorderRadius.circular(5),
                                      items: aimagItems(GlobalHelpers.aimagList.aimags!)
                                    ),
                                  ),
                                 GetX<SurveyController>(builder: (surveyController){
                                   return  Container(
                                    padding: const EdgeInsets.only(left: 0, right: 0, top: 10, bottom: 0),
                                    child: DropdownButton<String>(
                                      hint: myText(surveyControllerOut.researcherDefaultData.result!.sumName?? 'Сум, дүүргийн нэр?', 16, 2),
                                      value: sumSelectVal,
                                      onChanged: (String? newValue){
                                        surveyControllerOut.checkData();
                                        setState(() {
                                          sumSelectVal = newValue.toString();
                                        });
                                      },
                                      underline: const SizedBox(),
                                      isExpanded: true,
                                      borderRadius: BorderRadius.circular(5),
                                      items: sumItems(GlobalHelpers.aimagList.aimags![surveyController.chosenAimag.value].sums!)
                                    ),
                                  );
                                 })
                                                ],
                                              ),
                              )
                            ],
                          ),
                        ): const SizedBox(),
                  widget.pageIndex == 0? MyTextField(hinttxt:'Регистрийн дугаар', txtController: surveyControllerOut.rdTxtController, 
                                                     margint:0, marginb: 0, marginr: 20, marginl: 20, questionID:0, answerIndex:0, mark:'rd') : const SizedBox(),
                  widget.pageIndex == 0? GetX<SettingController>(builder: (settingsController){
                    return SizedBox(
                      child: 
                      settingsController.xyrServiceSwitcher.value? const SizedBox(): Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
                            child: TextField(
                               decoration: const InputDecoration(
                                 hintText: 'Овог',
                                 labelText: 'Овог'
                               ),
                               controller: surveyControllerOut.lastName,)
                          ),
                           Container(
                            margin: const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
                            child: TextField(
                               decoration: const InputDecoration(
                                 hintText: 'Нэр',
                                 labelText: 'Нэр'
                               ),
                               controller: surveyControllerOut.firstName,)
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
                            child: TextField(
                               decoration: const InputDecoration(
                                 hintText: 'Нас',
                                 labelText: 'Нас'
                               ),
                               controller: surveyControllerOut.age,)
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
                            child: TextField(
                               decoration: const InputDecoration(
                                 hintText: 'Хүйс',
                                 labelText: 'Хүйс'
                               ),
                               controller: surveyControllerOut.gender,)
                          )
                          
                        ],
                      ),
                    );
                  }) : const SizedBox(),
                  
                  widget.pageIndex == 0? GetX<SurveyController>(builder: (surveyController){
                    return myText(surveyControllerOut.xyrName.value, 15, 1, FontWeight.bold);
                  }) : const SizedBox(),
                SizedBox(
                height: widget.pageIndex == 0? GeneralMeasurements.deviceHeight*.7: GeneralMeasurements.deviceHeight*.8,
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                    //svvliin huudas bish bol togtmol item bgaad mon bol asuultiig 
                    //togtmol toondoo huvaagaad vldegdeltei bol tuhain vldegdeleer item
                    //count aa ogoh
                    itemCount: widget.pageIndex == GlobalHelpers.surveyPageCount-1? 
                    surveyControllerOut.queryQuestions.result!.questions!.length%AllSizes.pageQuestionCount != 0?
                    surveyControllerOut.queryQuestions.result!.questions!.length%AllSizes.pageQuestionCount : AllSizes.pageQuestionCount : AllSizes.pageQuestionCount,
                    itemBuilder: (BuildContext context, int index){
                      final int queryUnitIndex = widget.pageIndex * AllSizes.pageQuestionCount + index;
                      final item =  surveyControllerOut.queryQuestions.result!.questions![queryUnitIndex];
                      surveyControllerOut.textEditingControllers.add(TextEditingController());
                      surveyControllerOut.dropvalueList.add(DropSelectVal());
                    return RecieverUnit(questionID: item.id!, type: item.type, questionText: item.questionText, 
                                        questionIndex: queryUnitIndex, options: item.options);
                  }),
                ),
                widget.pageIndex == GlobalHelpers.surveyPageCount-1? 
                Row(mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 25),
                      child: InkWell(
                        onTap: (){
                           if(surveyControllerOut.pushDataBtn.value){
                            pushData();
                            Future.delayed(const Duration(seconds: 3),(){surveyControllerOut.pushDataBtn.value = true;});
                           }
                        },
                        child: myBtn(CommonColors.geregeBlue, GeneralMeasurements.deviceWidth*.2, GeneralMeasurements.deviceHeight*.05, 
                      CommonColors.geregeBlue, Colors.white, 'Done'),
                      ),
                    )
                  ],) :  const SizedBox()
                ],
              ),
      ),
      Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            widget.pageIndex != 0? Container(
              width: GeneralMeasurements.deviceWidth*.01,
              height: GeneralMeasurements.deviceHeight*.8,
              decoration: BoxDecoration(
                color: CommonColors.geregeBlue,
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(0), topRight: Radius.circular(10),
                                                 bottomLeft: Radius.circular(0), bottomRight: Radius.circular(10)) 
              ),
            ): const SizedBox(),
            widget.pageIndex != GlobalHelpers.surveyPageCount-1? Container(
              width: GeneralMeasurements.deviceWidth*.01,
              height: GeneralMeasurements.deviceHeight*.8,
              decoration: BoxDecoration(
                color: CommonColors.geregeBlue,
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(0),
                                                 bottomLeft: Radius.circular(10), bottomRight: Radius.circular(0)) 
              ),
            ) : const SizedBox()
          ],
        ),
      ),
      Align(
        alignment: Alignment.bottomLeft,
        child: Container(
          margin: EdgeInsets.all(20),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey)
          ),
          child: Text((widget.pageIndex + 1).toString() + '/' + GlobalHelpers.surveyPageCount.toString())
          ),
      )
        ],
      ),
    );
  }
}


///хариултыг оруулах item 
class RecieverUnit extends StatefulWidget {
  const RecieverUnit({ Key? key,required this.questionID, this.type,
                       this.questionText, required this.questionIndex,
                       this.options}) 
  : super(key: key);
  final int questionID;
  final type;
  final questionText;
  final int questionIndex;
  final List<Options>? options;
  @override
  State<RecieverUnit> createState() => _RecieverUnit();
}
class _RecieverUnit extends State<RecieverUnit> {
  var queryController = Get.find<SurveyController>();
  Widget categorization(int type){
    switch (type) {
        case 0:
          return MyTextField(hinttxt:widget.questionText, txtController:queryController.textEditingControllers[widget.questionIndex], margint: 5, marginb: 5, 
          marginr: 20, marginl:  20, 
                            questionID: widget.questionID, answerIndex: widget.questionIndex, mark: 'query');                        
        default: return MyDropdown(dropDownHint: widget.questionText, listitems: widget.options, 
                              currentValue: 0, mark: 'mark', givenModelType: Options, 
                              margint: 5, marginb: 5, marginr: 20, marginl: 20, questionID: widget.questionID,
                              answerIndex: widget.questionIndex);
                        // MyRadioBtn(w: 1, title: widget.questionText, optionItems: widget.options,
                        //             questionID:  widget.questionID, questionIndex: widget.questionIndex,);        
      } 
  }
  @override
  Widget build(BuildContext context){
    return Container(
      child: categorization(widget.type?? 0) 
    );
  }
}
