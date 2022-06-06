import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orh_user_app_version1/Controllers/auth_controller.dart';
import 'dart:convert';
import 'package:orh_user_app_version1/Controllers/profile_controller.dart';
import 'package:orh_user_app_version1/Helpers/logging.dart';
import 'package:orh_user_app_version1/global_helpers.dart';
import '../../Models/SurveyRelated/response.dart';
import '../../Models/SurveyRelated/response_answers.dart';
import '../../Models/SurveyRelated/survey_answer_body.dart';
import '../../Models/SurveyRelated/survey_list.dart';
import '../../Models/general_response.dart';
import '../../global_constant.dart';
import '../../models/SurveyRelated/survey_body.dart';
class SurveyController extends GetxController{
  var ereklog = logger(SurveyController);
  //.......................................................
  List<DropSelectVal> dropvalueList = [];
  List<TextEditingController> textEditingControllers = [];
  //.......................................................

  static Map<String, dynamic> listJBody(int userId, String searchTxt){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['search_txt'] = searchTxt;
    return data;
  }
  var surveyList = SurveyListBody().obs;
  Future listGet(String routekey, String messageCode, int userId, String searchTxt) async{
    var data = await GlobalHelpers.postRequestGeneral.getdata(listJBody(userId, searchTxt), messageCode, UriAdresses.medCore);
    switch(routekey){
      case '/home':
      surveyList.value = SurveyListBody.fromJson(jsonDecode(data.toString()));
      break;
      case '/profile':
      Get.find<ProfileController>().ownSurveyListbody.value = SurveyListBody.fromJson(jsonDecode(data.toString()));
      break;
    }
  }

  var wrkSpaceSurveyList = SurveyListBody().obs;
   Future segmentedlistGet(String routekey, String messageCode, int userId, String searchTxt) async{
    var data = await GlobalHelpers.postRequestGeneral.getdata(listJBody(userId, searchTxt), messageCode, UriAdresses.medCore);
    ereklog.wtf(listJBody(userId, searchTxt));
    wrkSpaceSurveyList.value = SurveyListBody.fromJson(jsonDecode(data.toString()));
  }

  var pushDataBtn = true.obs;
  SurveyAnswer surveyAnswer = SurveyAnswer();
  GeneralResponse generalResponse = GeneralResponse();
  Future answersPush() async{//message code deeree toglood olon torliin asuultuud yavuulj bolno
     var jsondata = await GlobalHelpers.postRequestGeneral.getdata(surveyAnswer.toJson(), "120004", UriAdresses.medCore);
    log(jsonEncode(surveyAnswer.toJson()));
    print(jsondata.toString()+' '+'hariugaa yavuulsanii hariu');
    generalResponse = GeneralResponse.fromJson(jsonDecode(jsondata));
    switch(generalResponse.code){
      case '200':
          pushDataBtn.value = true;
          Get.snackbar('Амжилттай бүртгэгдлээ', '', snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white, backgroundColor: Colors.grey[900], margin: EdgeInsets.only(bottom: GeneralMeasurements.snackbarBottomMargin, left: 5, right: 5,));
          Get.offAllNamed(RouteUnits.home);
          break;
    }
  }

  var chosenSurveyId;
  var chosenSurveyIndx;
  Map<String, dynamic> chosenSurveyPayload(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['survey_id'] = '$chosenSurveyId';
    data['user_id'] = Get.find<AuthController>().user.result!.userId;
    return data;
  }
    Survey survey = Survey();
  Future surveyGet(int chosenIndx) async{
    var jsondata = await GlobalHelpers.postRequestGeneral.getdata(chosenSurveyPayload(), "120003", UriAdresses.medCore);
    ereklog.wtf(jsondata);
    survey = Survey.fromJson(jsonDecode(jsondata.toString()));
    switch(survey.code){
      case 200 :
      Get.toNamed(RouteUnits.surveyList + RouteUnits.individualSurvey, arguments: "");
      GlobalHelpers.bottomnavbarSwitcher.add(false);
      surveyAnswer.answers = List<Answers>.generate(survey.result!.questions!.length, ((index) => Answers()));
      surveyList.value.result!.items![chosenIndx].loading.value = false;
      break;
    }
  }
  var surveyDeleteIcon = false.obs;
  Future delete() async{
    var data = await GlobalHelpers.postRequestGeneral.getdata(chosenSurveyPayload(), "120007", UriAdresses.medCore);
    generalResponse = GeneralResponse.fromJson(jsonDecode(data.toString()));
    switch(generalResponse.code){
       case '200':
          break;
    }
  }
  SurveyResponsebody surveyResponses = SurveyResponsebody();
  Future responsesListGet() async{
    var data = await GlobalHelpers.postRequestGeneral.getdata(chosenSurveyPayload(), "120008", UriAdresses.medCore);
    surveyResponses = SurveyResponsebody.fromJson(jsonDecode(data.toString()));
    switch(surveyResponses.code){
       case 200:
         Get.toNamed(RouteUnits.surveyResponses);
          break;
    }
  }

  ResponseAnswersbody responseAnswers = ResponseAnswersbody();
  Future responseAnswersGet() async{
    var data = await GlobalHelpers.postRequestGeneral.getdata(chosenSurveyPayload(), '120010', UriAdresses.medCore);
    responseAnswers = ResponseAnswersbody.fromJson(jsonDecode(data.toString()));
    switch(responseAnswers.code){
      case 200:
      Get.toNamed(RouteUnits.surveyResponses + RouteUnits.responseAnswers);
      break;
    }
  }
}