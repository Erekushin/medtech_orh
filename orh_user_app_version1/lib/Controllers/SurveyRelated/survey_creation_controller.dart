import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:orh_user_app_version1/Controllers/SurveyRelated/survey_controller.dart';
import 'package:orh_user_app_version1/Helpers/logging.dart';
import 'package:orh_user_app_version1/Models/SurveyRelated/survey_creation_types.dart';
import 'package:orh_user_app_version1/Models/general_response.dart';
import 'package:orh_user_app_version1/global_constant.dart';
import 'package:orh_user_app_version1/global_helpers.dart';
import '../../Models/SurveyRelated/survey_answer_body.dart';
import '../../Models/SurveyRelated/survey_body.dart';

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
//  SurveyCreationbody surveyCreationbody = SurveyCreationbody();
Survey surveyCreationbody = Survey();
//survey make name
 var surveyNametxtCont = TextEditingController();
 var surveyInputLimitation = TextEditingController();
 var limitCountVis = false.obs;
 var TypeVis = false.obs;
 String? torolStr;
 String? counttypeStr;
 String? levelStr;
 String? torolNameStr;
 String? levelNameStr;

 String? randomString;
 int? slevel = 1;
 int? connectedid = 0;


  ///vvsgej bui Question vvdee hadaglah list
 var newQuestionList = <Questions>[].obs;
 var toolQuestionCount = 0.obs;
var surveyCreationPageController = PageController();

Future getSurveyCreationTypes()async{
  var data = await GlobalHelpers.postRequestGeneral.getdata({}, '120005', UriAdresses.medCore);
  ereklog.wtf(data);
  surveyCreationTypes = SurveyCreationTypes.fromJson(jsonDecode(data.toString()));
  switch(surveyCreationTypes.code){
    case 200 : 
    ereklog.wtf('200 irsen shvv');
    Get.toNamed(RouteUnits.surveyCreation, arguments: 0);
  }
}
Survey autosurvey = Survey();
Argu arg = Argu();
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
          if(TypeVis.value == true){
            autosurvey = Survey.fromJson(generalResponse.result);
            slevel = autosurvey.slevel! + 1;
            arg.sColor = surveyCreationbody.surveyClr;
            arg.type = "Auto";
            arg.count = autosurvey.questions!.length;
            Get.find<SCont>().surveyAnswer.answers = List<Answers>.generate(autosurvey.questions!.length, ((index) => Answers()));
            Get.toNamed(RouteUnits.surveyList + RouteUnits.individualSurvey, arguments: arg); 
            //done deer zov chiglvvleh
            // vvsgej bhdaa level iig ni haruulah
            //table deer column uudiig ni nemeh
          }
          else{
            Get.offAllNamed(RouteUnits.home);
          }
          break;
      case '400':
         Get.snackbar('Судалгааг хадаглаж чадсангүй', generalResponse.message.toString( ), snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white, backgroundColor: Colors.grey[900], margin:  const EdgeInsets.all(5));
      break;    
    }
    
  }
}