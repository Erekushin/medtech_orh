import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orh_user_app_version1/Controllers/login_controller.dart';
import 'package:orh_user_app_version1/Controllers/survey_controller.dart';
import 'package:orh_user_app_version1/Controllers/setting_controller.dart';
import 'package:orh_user_app_version1/MyWidgets/my_button.dart';
import 'package:orh_user_app_version1/global_constant.dart';
import 'package:orh_user_app_version1/global_helpers.dart';
import '../../MyWidgets/my_reciever_unit.dart';
import '../../MyWidgets/my_text.dart';
import '../../global_constant.dart';


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
  var settingsControllerOut = Get.find<SettingController>();
  var surveyControllerOut = Get.find<SurveyController>(); 
  void pushData(){
    surveyControllerOut.pushDataBtn.value = false;
    if(surveyControllerOut.haveDefaultData.value){//default aa shalgaad 
                            surveyControllerOut.surveyAnswer.researcherGeregeID = Get.find<LoginController>().geregeUser.result!.id;
                            surveyControllerOut.surveyAnswer.aimagCode = surveyControllerOut.researcherDefaultData.result!.aimagCode; 
                            surveyControllerOut.surveyAnswer.aimagName = surveyControllerOut.researcherDefaultData.result!.aimagName;
                            surveyControllerOut.surveyAnswer.sumCode = surveyControllerOut.researcherDefaultData.result!.sumCode;
                            surveyControllerOut.surveyAnswer.sumName = surveyControllerOut.researcherDefaultData.result!.sumName;
                            surveyControllerOut.surveyAnswer.regNo = surveyControllerOut.rdTxtController.text;
                            surveyControllerOut.surveyAnswer .surveyId = '4'; // saijruulna
                        if(settingsControllerOut.xyrServiceSwitcher.value){//xyr aa asaasan vgvvgee shalgaad 
                          if(GlobalHelpers.isXyrNull){
                             try{
                              surveyControllerOut.surveyAnswer.gender = surveyControllerOut.xyrInfo.result!.gender.toString();
                              surveyControllerOut.surveyAnswer.age = surveyControllerOut.xyrInfo.result!.age;
                              surveyControllerOut.surveyAnswer.fistName = surveyControllerOut.xyrInfo.result!.firstName;
                              surveyControllerOut.surveyAnswer.lastName = surveyControllerOut.xyrInfo.result!.lastName;
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
                                surveyControllerOut.surveyAnswer.gender = surveyControllerOut.gender.text;
                                surveyControllerOut.surveyAnswer.age = surveyControllerOut.age.text;
                                surveyControllerOut.surveyAnswer.fistName = surveyControllerOut.firstName.text;
                                surveyControllerOut.surveyAnswer.lastName = surveyControllerOut.lastName.text;
                                surveyControllerOut.surveyAnswersPush();
                                print('garaas medeelel oruulchaad yavuulah gej bna');
                            }
                            catch(e){
                               Get.snackbar('Алдаа', '$e!', snackPosition: SnackPosition.BOTTOM,
                               colorText: Colors.white, backgroundColor: Colors.grey[900], margin:  const EdgeInsets.all(5));
                            }
                        
                        }
                        else{
                           surveyControllerOut.surveyAnswer.researcherGeregeID = '';
                           surveyControllerOut.surveyAnswer.regNo = '';
                            surveyControllerOut.surveyAnswer.aimagCode = ''; 
                            surveyControllerOut.surveyAnswer.aimagName = '';
                            surveyControllerOut.surveyAnswer.sumCode = '';
                            surveyControllerOut.surveyAnswer.sumName = '';
                            surveyControllerOut.surveyAnswer .surveyId = '4'; // saijruulna
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
 
  @override
 
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        GlobalHelpers.bottomnavbarSwitcher.add(true);
        return true;
      },
      child: Stack(
        children: [
          SingleChildScrollView(//question ii item uudiig aguulj bui heseg
        child: Column(
                children: [
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
          Center(//huudsiin 2 talaar chimeglel baidlaar oruulsan tsenher container
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
          Align(//huudsiin toog haruuldag text
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

