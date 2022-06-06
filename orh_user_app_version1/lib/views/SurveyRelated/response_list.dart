import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orh_user_app_version1/Controllers/SurveyRelated/survey_controller.dart';

import '../../MyWidgets/my_text.dart';
import '../../global_constant.dart';


class SurveyResponses extends StatefulWidget {
  const SurveyResponses({ Key? key }) : super(key: key);

  @override
  State<SurveyResponses> createState() => _SurveyResponsesState();
}

class _SurveyResponsesState extends State<SurveyResponses> {
  var surveyCont = Get.find<SurveyController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: ListView.builder(
      itemCount: surveyCont.surveyResponses.result!.length,
      itemBuilder: (c, i){
        var item = surveyCont.surveyResponses.result![i];
        String? c = item.creartedDate;
        String? n =item.researcherName;
        return Container(
                  margin: EdgeInsets.all(GeneralMeasurements.deviceWidth*.02),
                  height: GeneralMeasurements.deviceHeight*.08,
                  decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xff040039).withOpacity(.15),
                      blurRadius: 99,
                    ),
                  ],
                  borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                    width: GeneralMeasurements.deviceWidth*.7,
                    child: myText('$c $n', 17, 1, FontWeight.w700), //queryController.childHeartQuery.result!.title??
                  )
                    ],
                  )
            ); 
      },
    ));
  }
}