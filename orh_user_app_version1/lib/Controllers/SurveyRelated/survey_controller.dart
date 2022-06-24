import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orh_user_app_version1/Controllers/auth_controller.dart';
import 'dart:convert';
import 'package:orh_user_app_version1/Helpers/logging.dart';
import 'package:orh_user_app_version1/Models/SurveyRelated/statistic_answer.dart';
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
  List<DropSelectVal> statisticTypeList = [];
  List<TextEditingController> textEditingControllers = [];
  //.......................................................

  static Map<String, dynamic> listJBody(int userId, String searchTxt, String phone){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['search_txt'] = searchTxt;
    data['phone'] = phone;
    return data;
  }
  var publicSurveyList = SurveyListBody().obs;
  var ownSurveyListbody = SurveyListBody().obs;
  var wrkSpaceSurveyList = SurveyListBody().obs;
  var attachedList = SurveyListBody().obs;
  Future listGet(String routekey, String messageCode, int userId, String searchTxt, String phone) async{
    var data = await GlobalHelpers.postRequestGeneral.getdata(listJBody(userId, searchTxt, phone), messageCode, UriAdresses.medCore);
    ereklog.wtf(data);
    switch(routekey){
      case '/home':
      publicSurveyList.value = SurveyListBody.fromJson(jsonDecode(data.toString()));
      break;
      case '/segmented':
      wrkSpaceSurveyList.value = SurveyListBody.fromJson(jsonDecode(data.toString()));
      break; 
      case '/profile':
      ownSurveyListbody.value = SurveyListBody.fromJson(jsonDecode(data.toString()));
      break;
      case '/attachedList':
      attachedList.value = SurveyListBody.fromJson(jsonDecode(data.toString()));
      break;
    }
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
          GlobalHelpers.workingWithCode.clearSurveyAnswers();
          Get.offAllNamed(RouteUnits.home);
          break;
      case '400':
          pushDataBtn.value = true;
          Get.snackbar('Хариуг хадгалж чадсангүй', '', snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white, backgroundColor: Colors.grey[900], margin: EdgeInsets.only(bottom: GeneralMeasurements.snackbarBottomMargin, left: 5, right: 5,));
          break;
    }
  }

  var chosenSurveyId;
  var chosenSurveyIndx;
  Map<String, dynamic> chosenSurveyPayload(String createdDate, String username){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['survey_id'] = '$chosenSurveyId';
    data['user_id'] = Get.find<AuthController>().user.result!.userId;
    data['created_date'] = createdDate;
    data['user_name'] = username;
    return data;
  }
  Survey survey = Survey();
  Future surveyGet(int chosenIndx,String surveyColor, String route) async{
    var jsondata = await GlobalHelpers.postRequestGeneral.getdata(chosenSurveyPayload('', ''), "120003", UriAdresses.medCore);
    ereklog.wtf(jsondata);
    survey = Survey.fromJson(jsonDecode(jsondata.toString()));
    switch(survey.code){
      case 200 :
      Get.toNamed(RouteUnits.surveyList + RouteUnits.individualSurvey, arguments: surveyColor);
      GlobalHelpers.bottomnavbarSwitcher.add(false);
      surveyAnswer.answers = List<Answers>.generate(survey.result!.questions!.length, ((index) => Answers()));
      switch(route){
        case '/home':
        publicSurveyList.value.result![chosenIndx].loading.value = false;
        break;
        case '/segmented':
        wrkSpaceSurveyList.value.result![chosenIndx].loading.value = false;
        break;
      }
      
      break;
    }
  }
  var surveyDeleteIcon = false.obs;
  Future delete() async{
    var data = await GlobalHelpers.postRequestGeneral.getdata(chosenSurveyPayload('', ''), "120007", UriAdresses.medCore);
    generalResponse = GeneralResponse.fromJson(jsonDecode(data.toString()));
    ereklog.wtf(data);
    switch(generalResponse.code){
       case '200':
       Get.snackbar('Амжилттай устлаа', '', snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white, backgroundColor: Colors.grey[900], margin: EdgeInsets.only(bottom: GeneralMeasurements.snackbarBottomMargin, left: 5, right: 5,));
       ownSurveyListbody.value.result!.removeAt(chosenSurveyIndx);
          break;
    }
  }
  SurveyResponsebody surveyResponses = SurveyResponsebody();
  Future responsesListGet(String username) async{
    var data = await GlobalHelpers.postRequestGeneral.getdata(chosenSurveyPayload('', username), "120008", UriAdresses.medCore);
    ereklog.wtf(data);
    surveyResponses = SurveyResponsebody.fromJson(jsonDecode(data.toString()));
    ereklog.wtf(data);
    ereklog.wtf(chosenSurveyPayload('', username));
    switch(surveyResponses.code){
       case 200:
         await responseStatisticGet();
         Get.toNamed(RouteUnits.surveyResponses);
          break;
    }
  }
    SurveyListBody respondResearchers =SurveyListBody();
    Future respondResearchersListGet(int chosenIndx) async{
    var data = await GlobalHelpers.postRequestGeneral.getdata(chosenSurveyPayload('', ''), "120011", UriAdresses.medCore);
    respondResearchers = SurveyListBody.fromJson(jsonDecode(data.toString()));
    ereklog.wtf(data);
    switch(respondResearchers.code){
       case 200:
         Get.toNamed(RouteUnits.respondResearchers);
         ownSurveyListbody.value.result![chosenIndx].loading.value = false;
          break;
    }
  }

  ResponseAnswersbody responseAnswers = ResponseAnswersbody();
  Future responseAnswersGet(String createdDate) async{
    var data = await GlobalHelpers.postRequestGeneral.getdata(chosenSurveyPayload(createdDate, ''), '120010', UriAdresses.medCore);
    responseAnswers = ResponseAnswersbody.fromJson(jsonDecode(data.toString()));
    ereklog.wtf(data);
    ereklog.wtf(chosenSurveyPayload(createdDate, ''));
    switch(responseAnswers.code){
      case 200:
      Get.toNamed(RouteUnits.surveyResponses + RouteUnits.responseAnswers);
      break;
    }
  }

  Statistic statisticAnswer = Statistic();
  Future responseStatisticGet() async{
    var data = await GlobalHelpers.postRequestGeneral.getdata(surveyResponses.toJson(), '120100', UriAdresses.medCore);
    ereklog.wtf(surveyResponses.toJson());
    ereklog.wtf(data);
    statisticAnswer = Statistic.fromJson(jsonDecode(data.toString()));
  }
}