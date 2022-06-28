import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:orh_user_app_version1/Helpers/logging.dart';
import 'package:orh_user_app_version1/Models/SurveyRelated/survey_creation_types.dart';
import 'package:orh_user_app_version1/Models/general_response.dart';
import 'package:orh_user_app_version1/global_constant.dart';
import 'package:orh_user_app_version1/global_helpers.dart';
import '../../Models/SurveyRelated/survey_creation_body.dart';

class CreationCont extends GetxController {
final ereklog = logger(CreationCont);


  List<DropSelectVal> qTypes = [];
  List<DropSelectVal> staTypes = [];
  List<TextEditingController> qTxts = [];

SurveyCreationTypes surveyCreationTypes = SurveyCreationTypes();
GeneralResponse generalResponse = GeneralResponse();
///sudlaachid zoriulsan sudalgaanii sudlaachidiin jagsaalt
var researchetTextController = <TextEditingController>[].obs;
List<Researchers> researcherPhoneList = <Researchers>[];
///survey vvsgeh hvseltiin biy
 SurveyCreationbody surveyCreationbody = SurveyCreationbody();
//survey make name
 var surveyNametxtCont = TextEditingController();
 var surveyInputLimitation = TextEditingController();
 var limitCountVis = false.obs;
 String? torolStr;
 String? levelStr;
 String? torolNameStr;
 String? levelNameStr;
  ///vvsgej bui Question vvdee hadaglah list
 var newQuestionList = <Question>[].obs;
 var toolQuestionCount = 0.obs;
var surveyCreationPageController = PageController();

Future getSurveyCreationTypes()async{
  var data = await GlobalHelpers.postRequestGeneral.getdata({}, '120005', UriAdresses.medCore);
  ereklog.wtf(data);
  surveyCreationTypes = SurveyCreationTypes.fromJson(jsonDecode(data.toString()));
  switch(surveyCreationTypes.code){
    case 200 : 
    ereklog.wtf('200 irsen shvv');
    Get.toNamed(RouteUnits.surveyCreation);
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
          Get.snackbar('Амжилттай', '', snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white, backgroundColor: Colors.grey[900], margin:  const EdgeInsets.all(5));
          GlobalHelpers.workingWithCode.clearSurveyCreation();
          break;
      case '400':
         Get.snackbar('Судалгааг хадаглаж чадсангүй', generalResponse.message.toString( ), snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white, backgroundColor: Colors.grey[900], margin:  const EdgeInsets.all(5));
      break;    
    }
    
  }
}