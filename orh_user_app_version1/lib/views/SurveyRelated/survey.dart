import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orh_user_app_version1/Controllers/SurveyRelated/survey_controller.dart';
import 'package:orh_user_app_version1/Controllers/auth_controller.dart';
import 'package:orh_user_app_version1/Controllers/setting_controller.dart';
import 'package:orh_user_app_version1/MyWidgets/my_button.dart';
import 'package:orh_user_app_version1/global_constant.dart';
import 'package:orh_user_app_version1/global_helpers.dart';
import '../../Controllers/SurveyRelated/survey_creation_controller.dart';
import '../../Models/SurveyRelated/survey_body.dart';
import '../../MyWidgets/my_reciever_unit.dart';
import '../../global_constant.dart';

class SurveyUnit extends StatefulWidget {
  const SurveyUnit({Key? key}) : super(key: key);
  @override
  State<SurveyUnit> createState() => _SurveyUnit();
}

class _SurveyUnit extends State<SurveyUnit> {
  var argu = Get.arguments as Argu;
  var pageController = PageController();
  final queryController = Get.find<SCont>();
  var sCCont = Get.find<CreationCont>();
  final settingsController = Get.find<SettingController>();
  @override
  void initState() {
    super.initState();
    GlobalHelpers.surveyPageCount =
        argu.count! ~/ AllSizes.pageQuestionCount + 1;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: PageView.builder(
          controller: pageController,
          itemCount: GlobalHelpers.surveyPageCount,
          itemBuilder: (context, index) {
            return PageUnit(
              pageIndex: index,
              pageColor: argu.sColor!,
              currentlvl: argu.surveylvl!,
            );
          }),
    ));
  }
}

///судалгааны асуултуудыг харуулах хуудас
class PageUnit extends StatefulWidget {
  const PageUnit(
      {Key? key,
      required this.pageIndex,
      required this.pageColor,
      required this.currentlvl})
      : super(key: key);
  final int pageIndex;
  final String pageColor;
  final int currentlvl;
  @override
  State<PageUnit> createState() => _PageUnitState();
}

class _PageUnitState extends State<PageUnit> {
  final argu = Get.arguments as Argu;
  var settingsControllerOut = Get.find<SettingController>();
  var sCont = Get.find<SCont>();
  var sCCont = Get.find<CreationCont>();
  List<Questions>? questions;
  int? level;
  String? groupid;
  int? connectedid;

  var authCon = Get.find<AuthController>();
  @override
  @override
  Widget build(BuildContext context) {
    switch (argu.type) {
      case "Normal":
        questions = sCont.survey.questions;
        level = sCont.survey.slevel;
        groupid = sCont.survey.groupid;
        connectedid = sCont.survey.connectedid;
        break;
      case "Auto":
        questions = sCCont.surveys[argu.key!].questions;
        break;
      case "nxtLevel":
        questions = sCont.sNxtLvl.questions;
        break;
    }

    int pageClrInt = int.parse(widget.pageColor);
    return WillPopScope(
      onWillPop: () async {
        GlobalHelpers.bottomnavbarSwitcher.add(false);
        GlobalHelpers.workingWithCode.clearSurveyAnswers();
        return true;
      },
      child: Container(
        decoration: BoxDecoration(color: Color(pageClrInt)),
        child: Stack(
          children: [
            SingleChildScrollView(
              //question ii item uudiig aguulj bui heseg
              child: Column(
                children: [
                  SizedBox(
                    height: widget.pageIndex == 0
                        ? GeneralMeasurements.deviceHeight * .87
                        : GeneralMeasurements.deviceHeight * .8,
                    child: ListView.builder(
                        physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        //svvliin huudas bish bol togtmol item bgaad mon bol asuultiig
                        //togtmol toondoo huvaagaad vldegdeltei bol tuhain vldegdeleer item
                        //count aa ogoh
                        itemCount: widget.pageIndex ==
                                GlobalHelpers.surveyPageCount - 1
                            ? argu.count! % AllSizes.pageQuestionCount != 0
                                ? argu.count! % AllSizes.pageQuestionCount
                                : AllSizes.pageQuestionCount
                            : AllSizes.pageQuestionCount,
                        itemBuilder: (BuildContext context, int index) {
                          final int queryUnitIndex =
                              widget.pageIndex * AllSizes.pageQuestionCount +
                                  index;
                          Questions item = questions![queryUnitIndex];
                          sCont.textEditingControllers
                              .add(TextEditingController());
                          sCont.dropvalueList.add(DropSelectVal());
                          sCont.surveyAnswer.answers?[queryUnitIndex]
                              .statistic = item.statistic;
                          return RecieverUnit(
                              questionID: item.id!,
                              type: item.type,
                              questionText: item.questionText,
                              questionIndex: queryUnitIndex,
                              options: item.options);
                        }),
                  ),
                  widget.pageIndex == GlobalHelpers.surveyPageCount - 1
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 25),
                              child: InkWell(
                                onTap: () {
                                  if (sCont.pushDataBtn.value) {
                                    if (sCCont.sSwitcher.value) {
                                      GlobalHelpers.workingWithCode
                                          .clearSurveyAnswers();

                                      //level 2 deer daraahiig songoj bolohgvi bh uchir bvgdiig ni null
                                      //tei tentsvvlev
                                      SCargubody sCargubody = SCargubody();
                                      sCargubody.initialPage = 1;
                                      sCargubody.fromRoute =
                                          RouteUnits.individualSurvey;
                                      sCCont.surveyCreationTypes.result!
                                          .countType = null;
                                      sCCont.surveyCreationTypes.result!
                                          .surveyType = null;
                                      sCCont.surveyCreationTypes.result!
                                          .privacyLevel = null;
                                      Get.toNamed(RouteUnits.surveyCreation,
                                          arguments: sCargubody);
                                    } else {
                                      sCont.answersPush(widget.currentlvl);
                                    }
                                    Future.delayed(const Duration(seconds: 3),
                                        () {
                                      sCont.pushDataBtn.value = true;
                                    });
                                  }
                                },
                                child: myBtn(
                                    CommonColors.geregeBlue,
                                    GeneralMeasurements.deviceWidth * .2,
                                    GeneralMeasurements.deviceHeight * .05,
                                    CommonColors.geregeBlue,
                                    Colors.white,
                                    'Done'),
                              ),
                            )
                          ],
                        )
                      : const SizedBox()
                ],
              ),
            ),
            Center(
              //huudsiin 2 talaar chimeglel baidlaar oruulsan tsenher container
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  widget.pageIndex != 0
                      ? Container(
                          width: GeneralMeasurements.deviceWidth * .01,
                          height: GeneralMeasurements.deviceHeight * .8,
                          decoration: BoxDecoration(
                              color: CommonColors.geregeBlue,
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(0),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(0),
                                  bottomRight: Radius.circular(10))),
                        )
                      : const SizedBox(),
                  widget.pageIndex != GlobalHelpers.surveyPageCount - 1
                      ? Container(
                          width: GeneralMeasurements.deviceWidth * .01,
                          height: GeneralMeasurements.deviceHeight * .8,
                          decoration: BoxDecoration(
                              color: CommonColors.geregeBlue,
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(0),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(0))),
                        )
                      : const SizedBox()
                ],
              ),
            ),
            Align(
              //huudsiin toog haruuldag text
              alignment: Alignment.bottomLeft,
              child: Container(
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey)),
                  child: Text((widget.pageIndex + 1).toString() +
                      '/' +
                      GlobalHelpers.surveyPageCount.toString())),
            )
          ],
        ),
      ),
    );
  }
}
