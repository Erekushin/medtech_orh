import 'package:flutter/material.dart';
import 'package:orh_user_app_version1/global_constant.dart';
import 'package:orh_user_app_version1/views/SurveyRelated/creation/survey_creation_general.dart';
import 'package:get/get.dart';
import 'package:orh_user_app_version1/views/SurveyRelated/creation/survey_creation_questions.dart';
import 'package:orh_user_app_version1/views/SurveyRelated/creation/survey_save.dart';
import '../../../Controllers/SurveyRelated/survey_creation_controller.dart';
import '../../../Controllers/SurveyRelated/survey_controller.dart';
import '../../../global_helpers.dart';

class SurveyCreation extends StatefulWidget {
  const SurveyCreation({Key? key}) : super(key: key);
  @override
  State<SurveyCreation> createState() => _SurveyCreationState();
}

class _SurveyCreationState extends State<SurveyCreation> {
  var surveyCreationController = Get.find<CreationCont>();
  var surveyController = Get.find<SCont>();
  var argu = Get.arguments as SCargubody;
  @override
  void initState() {
    super.initState();
    surveyCreationController.surveyCreationPageController =
        PageController(initialPage: argu.initialPage!);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: PageView.builder(
          controller: surveyCreationController.surveyCreationPageController,
          itemCount: 3,
          itemBuilder: (context, index) {
            return SurveyCreationPageUnit(
              indx: index,
              route: argu.fromRoute!,
            );
          }),
    ));
  }
}

class SurveyCreationPageUnit extends StatefulWidget {
  const SurveyCreationPageUnit(
      {Key? key, required this.indx, required this.route})
      : super(key: key);
  final int indx;
  final String route;
  @override
  State<SurveyCreationPageUnit> createState() => _SurveyCreationPageUnitState();
}

class _SurveyCreationPageUnitState extends State<SurveyCreationPageUnit> {
  var surveyCreationController = Get.find<CreationCont>();
  Widget categorizing(int i) {
    switch (i) {
      case 0:
        return SurveyCreationGeneral(
          route: widget.route,
        );
      case 1:
        return const SurveyCreationQuestion();
      case 2:
        return const SurveyInfoCheck();
      default:
        return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          categorizing(widget.indx),
          Center(
            //huudsiin 2 talaar chimeglel baidlaar oruulsan tsenher container
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                widget.indx != 0
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
                widget.indx != 3
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
          )
        ],
      ),
    );
  }
}
