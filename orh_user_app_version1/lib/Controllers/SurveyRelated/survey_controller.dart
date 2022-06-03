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
import '../../Models/SurveyRelated/survey_answer_body.dart';
import '../../Models/SurveyRelated/survey_list.dart';
import '../../Models/result.dart';
import '../../global_constant.dart';
import '../../models/SurveyRelated/aimags.dart';
import '../../models/SurveyRelated/survey_body.dart';
import '../../models/SurveyRelated/researcher_default.dart';
class DropSelectVal{
  DropSelectVal({this.value});
  String? value;
}
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
  Future getAimagList() async {
    String jsonString = await loadFromAsset("assets/file/addresses.json");
    var aimagListStr = jsonDecode(jsonString);
    GlobalHelpers.aimagList = AimagList.fromJson(aimagListStr);
  }
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
    final geregeID = Get.find<AuthController>().medtech_user.result!.userId;
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = geregeID;
    return data;
  }

   static Map<String, dynamic> surveyListPayload(int UserId, String search_txt){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = UserId;
    data['search_txt'] = search_txt;
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
  // Future surveyQuestionsGet() async{
  //   var jsondata = await GlobalHelpers.postRequestGeneral.getdata(chosenSurveyPayload(), "120003", UriAdresses.medCore);
  //   ereklog.wtf(jsondata);
  //   survey = Survey.fromJson(jsonDecode(jsondata.toString()));
  //   for(int i = 0; i< survey.result![0].questions!.length; i++){
  //     ereklog.i(survey.result![0].questions![i].questionText);
  //     if(survey.result!.questions![i].options != null){
  //        for(int a = 0; a<survey.result!.questions![i].options!.length; a++){
  //       ereklog.wtf(survey.result!.questions![i].options![a].optionText);
  //     }
  //     }
  //   }
  //   Get.toNamed(RouteUnits.surveyList + RouteUnits.individualSurvey, arguments: "");
  //   // Get.toNamed(RouteUnits.answerform);
  //   GlobalHelpers.bottomnavbarSwitcher.add(false);
  //   surveyAnswer.answers = List<Answers>.generate(survey.result!.questions!.length, ((index) => Answers()));
  // }

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

  //hvvhdiin zvrhnii emgeg ilrvvlehed zoriulsan additional function
  Future isResearcherAuth() async{
    childHeartQuerybtnloading.value = true;
    var data = await GlobalHelpers.postRequestGeneral.getdata(geregeId(), "2035232", UriAdresses.covidBackEnd);
    log(jsonEncode(geregeId()));
    var response = GeneralResponse.fromJson(jsonDecode(data.toString()));
    switch(response.code){
       case '200':
          childHeartQuerybtnloading.value = false;
          researcherDefaultDataGet();
          // surveyQuestionsGet();
          GlobalHelpers.loopCheck = 0;
          break;
        case '100':
          childHeartQuerybtnloading.value = false;
          Get.snackbar('Интернет Алдаа', 'Та интернетээ шалгана уу!', snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white, backgroundColor: Colors.grey[900], margin: EdgeInsets.only(bottom: GeneralMeasurements.snackbarBottomMargin, left: 5, right: 5,));
          break;
        case '101': 
          childHeartQuerybtnloading.value = false;
          Get.snackbar('Интернет Алдаа', 'Та интернетээ шалгана уу!', snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white, backgroundColor: Colors.grey[900], margin: EdgeInsets.only(bottom: GeneralMeasurements.snackbarBottomMargin, left: 5, right: 5,));
          break;
        case '400': 
          childHeartQuerybtnloading.value = false;
          Get.defaultDialog(title: 'Таньд судалгаа авах эрх үүсээгүй байна', content: Image.asset('assets/images/thinkingBoy.png'));
          break;
        case 'Unauthorized':
          GlobalHelpers.loopCheck++;
          if(GlobalHelpers.loopCheck < 10){
            Get.find<AuthController>().geregeUserLogin((){isResearcherAuth();});
          }
          else{
          Get.snackbar('Аюултай!!', 'Программаа дахин оруулна уу!. Хэрвээ уг алдаа дахин гарвал харилцагчийн төвд хандана уу.', snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white, backgroundColor: Colors.grey[900], margin: EdgeInsets.only(bottom: GeneralMeasurements.snackbarBottomMargin, left: 5, right: 5,));
          }
          break;
        default : break;  
    }
  }

  Future researcherDefaultDataGet() async{
    var jsondata = await GlobalHelpers.postRequestGeneral.getdata(geregeId(), "2035226", UriAdresses.covidBackEnd);
    researcherDefaultData = ResearcherDefaultData.fromJson(jsonDecode(jsondata.toString()));
    researcherDefaultData.result!.currentDate = currentDate.toString().substring(0, 10);
    var a = researcherDefaultData.code;
    print(' default data nii code $a');
    switch(researcherDefaultData.code){
      case 200:
          haveDefaultData.value = true;
          Get.snackbar('Байршилын мэдээллийг авлаа', '', snackPosition: SnackPosition.BOTTOM, 
          colorText: Colors.white, backgroundColor: Colors.grey[900], margin:  const EdgeInsets.only(left: 5, top: 5, bottom: 75));
          break;
      case 100:
          Get.snackbar('Интернет Алдаа', 'Та интернетээ шалгана уу!', snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white, backgroundColor: Colors.grey[900], margin:  const EdgeInsets.only(left: 5, top: 5, bottom: 75));
          break;
      case 101: 
          Get.snackbar('Интернет Алдаа', 'Та интернетээ шалгана уу!', snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white, backgroundColor: Colors.grey[900], margin: EdgeInsets.only(bottom: GeneralMeasurements.snackbarBottomMargin, left: 5, right: 5,));
          break;
        default : break;  
    }
  }

  Future researcherDefaultDataUpdateAndPush() async{
    var jsondata = await GlobalHelpers.postRequestGeneral.getdata(researcherDefaultData.result!.toJson(), "2035231", UriAdresses.covidBackEnd);
    generalResponse = GeneralResponse.fromJson(jsonDecode(jsondata.toString()));
    log(json.encode(researcherDefaultData.result!.toJson()));
    print(generalResponse.code! + "dfdfdfdf");
    switch(generalResponse.code){
       case '200':
          Get.snackbar('Байршилын мэдээллийг хадгаллаа', '', snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white, backgroundColor: Colors.grey[900], margin:  const EdgeInsets.all(5));
        GlobalHelpers.loopCheck = 0;
        break;
      case 'Unauthorized':
        GlobalHelpers.loopCheck++;
          if(GlobalHelpers.loopCheck < 10){
            Get.find<AuthController>().geregeUserLogin((){Get.find<SurveyController>().researcherDefaultDataUpdateAndPush();});
          }
          else{
          Get.snackbar('Аюултай!!', 'Программаа дахин оруулна уу!. Хэрвээ уг алдаа дахин гарвал харилцагчийн төвд хандана уу.', snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white, backgroundColor: Colors.grey[900], margin:  const EdgeInsets.all(5));
          }
        break;
    }
 
  }
  Future xyrInfoGet() async{
    var xyrInfoString = await GlobalHelpers.postRequestGeneral.getdata(rd(), "501002", UriAdresses.covidBackEnd);
    xyrInfo = XyrInfo.fromJson(jsonDecode(xyrInfoString.toString()));
    log(jsonEncode(rd()));
    switch(xyrInfo.code){
       case '200':
          GlobalHelpers.isXyrNull = true; 
          Get.snackbar('Иргэний мэдээллийг авлаа', '', snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white, backgroundColor: Colors.grey[900], margin: EdgeInsets.only(bottom: GeneralMeasurements.snackbarBottomMargin, left: 5, right: 5,));
          xyrName.value = xyrInfo.result!.firstName!;
          GlobalHelpers.loopCheck = 0;
          break;
      case '404': 
         GlobalHelpers.isXyrNull = false; 
          Get.snackbar('Талбарын мэдээлэл дутуу байна', 'Судалгаанд оролцогчийн Регистрийн дугаарыг оруулна уу!', snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white, backgroundColor: Colors.grey[900], margin: EdgeInsets.only(bottom: GeneralMeasurements.snackbarBottomMargin, left: 5, right: 5,));
        break;
      case 'Unauthorized':
      print('unauthorized ruu orson');
        GlobalHelpers.loopCheck++;
          if(GlobalHelpers.loopCheck < 10){
            Get.find<AuthController>().geregeUserLogin((){xyrInfoGet();});
          }
          else{
          Get.snackbar('Аюултай!!', 'Программаа дахин оруулна уу!. Хэрвээ уг алдаа дахин гарвал харилцагчийн төвд хандана уу.', snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white, backgroundColor: Colors.grey[900], margin: EdgeInsets.only(bottom: GeneralMeasurements.snackbarBottomMargin, left: 5, right: 5,));
          }
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


}