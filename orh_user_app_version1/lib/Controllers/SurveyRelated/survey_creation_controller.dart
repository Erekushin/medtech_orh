import 'dart:convert';

import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:orh_user_app_version1/Helpers/logging.dart';
import 'package:orh_user_app_version1/Models/SurveyRelated/survey_creation_types.dart';
import 'package:orh_user_app_version1/Models/result.dart';
import 'package:orh_user_app_version1/global_constant.dart';
import 'package:orh_user_app_version1/global_helpers.dart';

import '../../Models/SurveyRelated/survey_creation_body.dart';

class SurveyCreationController extends GetxController {
final ereklog = logger(SurveyCreationController);
SurveyCreationTypes surveyCreationTypes = SurveyCreationTypes();
GeneralResponse generalResponse = GeneralResponse();
///sudlaachid zoriulsan sudalgaanii sudlaachidiin jagsaalt
var researchetTextController = <TextEditingController>[].obs;
List<Researchers> researchetIdList = <Researchers>[];
///survey vvsgeh hvseltiin biy
 SurveyCreationbody surveyCreationbody = SurveyCreationbody();
//survey make name
 var surveyNametxtController = TextEditingController();
 String? torolStr;
 String? levelStr;
 String? torolNameStr;
 String? levelNameStr;
  ///vvsgej bui Question vvdee hadaglah list
 List<Question> newQuestionList = <Question>[].obs;
 var toolQuestionCount = 0.obs;
var surveyCreationPageController = PageController();

Future getSurveyCreationTypes()async{
  var data = await GlobalHelpers.postRequestGeneral.getdata({}, '120005', UriAdresses.medCore);
  ereklog.wtf(data);
  surveyCreationTypes = SurveyCreationTypes.fromJson(jsonDecode(data.toString()));
  switch(surveyCreationTypes.code){
    case 200 : 
    ereklog.wtf('200 irsen shvv');
  }
}
Future surveyCreate() async{
    var jsonData = await GlobalHelpers.postRequestGeneral.getdata(surveyCreationbody.toJson(), "120001", UriAdresses.medCore);
    print('json data');
    ereklog.wtf(surveyCreationbody.toJson());
    ereklog.wtf(jsonData);
    generalResponse = GeneralResponse.fromJson(jsonDecode(jsonData));
    switch(generalResponse.code){
      case '200':
          ereklog.wtf('surveyQuestionPush deer 200 toi response irsen');
          break;
    }
    GlobalHelpers.workingWithCode.clearSurveyData();
  }
}