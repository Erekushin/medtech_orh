import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orh_user_app_version1/Controllers/SurveyRelated/survey_controller.dart';
import 'package:orh_user_app_version1/Controllers/auth_controller.dart';
import 'package:orh_user_app_version1/Controllers/setting_controller.dart';
import 'package:orh_user_app_version1/MyWidgets/my_button.dart';
import 'package:orh_user_app_version1/global_constant.dart';
import 'package:orh_user_app_version1/global_helpers.dart';
import '../../MyWidgets/my_reciever_unit.dart';
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
    GlobalHelpers.surveyPageCount = queryController.survey.result!.questions!.length~/AllSizes.pageQuestionCount+1;
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: PageView.builder(
              controller: pageController,
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
  var authCon = Get.find<AuthController>();
  void pushData(){
    surveyControllerOut.pushDataBtn.value = false;
    surveyControllerOut.surveyAnswer.researcherGeregeID = authCon.user.result!.userId;
    surveyControllerOut.surveyAnswer.surveyId = surveyControllerOut.chosenSurveyId;
    surveyControllerOut.surveyAnswer.fillerName = authCon.user.result!.userName;
    surveyControllerOut.surveyAnswer.createdDate = DateTime.now().toString().substring(0,10);
    try{
        surveyControllerOut.answersPush();
      }
   catch(e){
      Get.snackbar('Алдаа', '$e!', snackPosition: SnackPosition.BOTTOM,
      colorText: Colors.white, backgroundColor: Colors.grey[900], margin:  const EdgeInsets.all(5));
    }                   
  }
 
  @override
 
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        GlobalHelpers.bottomnavbarSwitcher.add(true);
        GlobalHelpers.workingWithCode.clearSurveyData();
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
                    surveyControllerOut.survey.result!.questions!.length%AllSizes.pageQuestionCount != 0?
                    surveyControllerOut.survey.result!.questions!.length%AllSizes.pageQuestionCount : AllSizes.pageQuestionCount : AllSizes.pageQuestionCount,
                    itemBuilder: (BuildContext context, int index){
                      final int queryUnitIndex = widget.pageIndex * AllSizes.pageQuestionCount + index;
                      final item =  surveyControllerOut.survey.result!.questions![queryUnitIndex];
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

