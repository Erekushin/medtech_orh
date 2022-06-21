import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orh_user_app_version1/Controllers/SurveyRelated/survey_controller.dart';
import 'package:orh_user_app_version1/views/SurveyRelated/response/response_list.dart';
import 'package:orh_user_app_version1/views/SurveyRelated/response/statistics.dart';

import '../../../MyWidgets/waiting_screen.dart';

class SurveyResponses extends StatefulWidget {
  const SurveyResponses({ Key? key }) : super(key: key);
  @override
  State<SurveyResponses> createState() => _SurveyResponsesState();
}

class _SurveyResponsesState extends State<SurveyResponses> {
  var surveyCont = Get.find<SurveyController>();
  staView(){
    if(surveyCont.statisticAnswer.result![0].answers != null && surveyCont.statisticAnswer.result!.length != 1){
      return const ResStatistic();
    }
    else{
      return const WaitingScreen();
    }
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PageView(
        children: [
           const ResList(),
           staView()
        ],
      )
     );
  }
}

