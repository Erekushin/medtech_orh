import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:orh_user_app_version1/Controllers/auth_controller.dart';
import 'package:orh_user_app_version1/Controllers/profile_controller.dart';
import 'package:orh_user_app_version1/Helpers/logging.dart';
import 'package:orh_user_app_version1/Models/xyr.dart';
import 'package:orh_user_app_version1/global_helpers.dart';
import '../../Helpers/load_json_from_assest.dart';
import '../../Models/SurveyRelated/response.dart';
import '../../Models/SurveyRelated/survey_answer_body.dart';
import '../../Models/SurveyRelated/survey_list.dart';
import '../../Models/result.dart';
import '../../global_constant.dart';
import '../../models/SurveyRelated/aimags.dart';
import '../../models/SurveyRelated/survey_body.dart';
import '../../models/SurveyRelated/researcher_default.dart';
class SurveyController extends GetxController{
  var surveyDeleteIcon = false.obs;
  var chosenSurveyId;
  var chosenSurveyIndx;
  var ereklog = logger(SurveyController);
 //xyr ajillahgvi vyd ajillah textfieldvvdiin controller
  var lastName = TextEditingController();
  var firstName = TextEditingController();
  var age = TextEditingController();
  var gender = TextEditingController();
  //.....................................................
  var surveyListbody = SurveyListBody().obs;
  List<DropSelectVal> dropvalueList = [];
  List<TextEditingController> textEditingControllers = [];
  ///bairshiliin medeelliig hadgalsan default medeelliin instance
  ResearcherDefaultData researcherDefaultData = ResearcherDefaultData();
  ///xyr iin instance
  XyrInfo xyrInfo = XyrInfo();
  ///base aas irj bui Question ii instance
  Survey survey = Survey(); 
  ///base ruu yavuulah hariunuudiig tsugluulj hiih sav
  SurveyAnswer surveyAnswer = SurveyAnswer();
  ///olon gazar ashiglagdaj boloh gerege response iin hamgiin 
  ///vndsen bvtetsiig zadlah instance
  GeneralResponse generalResponse = GeneralResponse();
  ///register iig hadaglah textEditingController
  var rdTxtController = TextEditingController();
  ///songogdson aimagiin id g sonsoh stream
  var chosenAimag = 0.obs; 
  ///researcher iin default data bvten bgaa esehiig sonsoh stream
  var haveDefaultData = false.obs;
  ///bairshilaa oruulah vydee aimag sum hoyroo hoyulang 
  ///ni songoj bgaa eseh
  var greenCheckIcon = false.obs;
  var xyrName = ''.obs;
  var childHeartQuerybtnloading = false.obs;
  var pushDataBtn = true.obs;
  
  DateTime currentDate = DateTime.now();
  checkData(){
    if(researcherDefaultData.result!.aimagCode != null && researcherDefaultData.result!.sumCode != null
        && researcherDefaultData.result!.currentDate != null){
      greenCheckIcon.value = true;
    }
  }
  checkQuestionCreationUnit(int unitIndex){
    //svvliin elementiig haraad 
    // text, dropuud utgaa avsan bnuu haraad 
    // utga butsaah
  }


   Map<String, dynamic> geregeId(){
    final geregeID = Get.find<AuthController>().user.result!.userId;
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = geregeID;
    return data;
  }

   static Map<String, dynamic> surveyListPayload(int userId, String searchTxt){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['search_txt'] = searchTxt;
    return data;
  }
   Map<String, dynamic> rd(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['search_text'] = rdTxtController.text;
    return data;
  }
  Future surveyListGet(String routekey, String messageCode, int userId, String searchTxt) async{
    var data = await GlobalHelpers.postRequestGeneral.getdata(surveyListPayload(userId, searchTxt), messageCode, UriAdresses.medCore);
    ereklog.wtf(data);
    ereklog.wtf(jsonEncode(surveyListPayload(userId, searchTxt)));
    switch(routekey){
      case '/home':
      surveyListbody.value = SurveyListBody.fromJson(jsonDecode(data.toString()));
      break;
      case '/profile':
      Get.find<ProfileController>().ownSurveyListbody.value = SurveyListBody.fromJson(jsonDecode(data.toString()));
      break;
    }
  }
  Future surveyQuestionsGet() async{
    var jsondata = await GlobalHelpers.postRequestGeneral.getdata(chosenSurveyPayload(), "120003", UriAdresses.medCore);
    ereklog.wtf(jsondata);
    survey = Survey.fromJson(jsonDecode(jsondata.toString()));
    Get.toNamed(RouteUnits.surveyList + RouteUnits.individualSurvey, arguments: "");
    // Get.toNamed(RouteUnits.answerform);
    GlobalHelpers.bottomnavbarSwitcher.add(false);
    surveyAnswer.answers = List<Answers>.generate(survey.result!.questions!.length, ((index) => Answers()));
  }

  Future surveyAnswersPush() async{//message code deeree toglood olon torliin asuultuud yavuulj bolno
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
  Map<String, dynamic> chosenSurveyPayload(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['survey_id'] = '$chosenSurveyId';
    return data;
  }
  Future deleteSurvey() async{
    var data = await GlobalHelpers.postRequestGeneral.getdata(chosenSurveyPayload(), "120007", UriAdresses.medCore);
    xyrInfo = XyrInfo.fromJson(jsonDecode(data.toString()));
    print('delete iig harii');
    print(chosenSurveyId);
    ereklog.wtf(chosenSurveyPayload());
    ereklog.wtf(data);
    log(jsonEncode(chosenSurveyPayload()));
    switch(xyrInfo.code){
       case '200':
         
          break;
    }
  }
  SurveyResponsebody surveyResponses = SurveyResponsebody();
  Future surveyAnswerListGet() async{
    var data = await GlobalHelpers.postRequestGeneral.getdata(chosenSurveyPayload(), "120008", UriAdresses.medCore);
    surveyResponses = SurveyResponsebody.fromJson(jsonDecode(data.toString()));
    switch(surveyResponses.code){
       case 200:
         Get.toNamed(RouteUnits.surveyResponses);
          break;
    }
  }

}