import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orh_user_app_version1/Controllers/auth_controller.dart';
import 'dart:convert';
import 'package:orh_user_app_version1/Helpers/logging.dart';
import 'package:orh_user_app_version1/global_helpers.dart';
import '../../Models/SurveyRelated/survey_answer_body.dart';
import '../../Models/SurveyRelated/survey_list.dart';
import '../../Models/general_response.dart';
import '../../global_constant.dart';
import '../../models/SurveyRelated/survey_body.dart';
class SCont extends GetxController{
  var ereklog = logger(SCont);
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
  GeneralResponse surveyGen = GeneralResponse();
  Survey survey = Survey();
  Future surveyGet(int chosenIndx,String surveyColor, String route) async{
    var jsondata = await GlobalHelpers.postRequestGeneral.getdata(chosenSurveyPayload('', ''), "120003", UriAdresses.medCore);
    ereklog.wtf(jsondata);
    surveyGen = GeneralResponse.fromJson(jsonDecode(jsondata.toString()));
    switch(surveyGen.code){
      case '200' :
      survey = Survey.fromJson(surveyGen.result);
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
}