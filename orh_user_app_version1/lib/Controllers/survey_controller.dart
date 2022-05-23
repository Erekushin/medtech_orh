import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:orh_user_app_version1/Controllers/login_controller.dart';
import 'package:orh_user_app_version1/Helpers/logging.dart';
import 'package:orh_user_app_version1/Models/xyr.dart';
import 'package:orh_user_app_version1/global_helpers.dart';
import '../Helpers/load_json_from_assest.dart';
import '../Models/SurveyRelated/survey_answer_body.dart';
import '../Models/SurveyRelated/survey_creation_body.dart';
import '../Models/SurveyRelated/survey_list.dart';
import '../Models/result.dart';
import '../global_constant.dart';
import '../models/SurveyRelated/aimags.dart';
import '../models/SurveyRelated/survey_question_body.dart';
import '../models/SurveyRelated/researcher_default.dart';

/// mydrop down ii utgiig hadaglah string bvhii class vvgeer form toi 
/// ijil hemjeenii list vvsgej bgaa
class DropSelectVal{
  DropSelectVal({this.value});
  String? value;
}
class SurveyController extends GetxController{
  var ereklog = logger(SurveyController);
 ///survey vvsgeh hvseltiin biy
 SurveyCreationbody   surveyCreationbody = SurveyCreationbody();
 ///vvsgej bui Question vvdee hadaglah list
 List<Question> newQuestionList = <Question>[].obs;

 //xyr ajillahgvi vyd ajillah textfieldvvdiin controller
  var lastName = TextEditingController();
  var firstName = TextEditingController();
  var age = TextEditingController();
  var gender = TextEditingController();
 //.....................................................
  
  ///survey iin list iig duudah vyd hvleej avah biy
  SurveyListBody surveyListbody = SurveyListBody();

  ///dropdown aas songogdson utguudiig hadaglah sav
  ///form iig zurah vyd questionii urttai ijilhen urtaar 
  ///vvsne utguudiig drop down aas question ii index eer yavuuldag
  List<DropSelectVal> dropvalueList = [];
  ///text utguudiig hadaglah sav form iig zurah vyd questionii 
  ///urttai ijilhen urtaar vvsne question ii index eer ni avch 
  ///parametereer ni yavuulaad controller oor ni holboson
  List<TextEditingController> textEditingControllers = [];
  ///bairshiliin medeelliig hadgalsan default medeelliin instance
  ResearcherDefaultData researcherDefaultData = ResearcherDefaultData();
  ///xyr iin instance
  XyrInfo xyrInfo = XyrInfo();
  ///base aas irj bui Question ii instance
  SurveyQuestions queryQuestions = SurveyQuestions(); 
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
  var chosenSurvey;
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
    final geregeID = Get.find<LoginController>().geregeUser.result!.id;
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = geregeID;
    return data;
  }
   Map<String, dynamic> queryPayload(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['survey_id'] = '$chosenSurvey';
    return data;
  }
   Map<String, dynamic> surveyList(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['survey_id'] = '';
    return data;
  }
   Map<String, dynamic> rd(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['search_text'] = rdTxtController.text;
    return data;
  }
  Future surveyListGet() async{
    var data = await GlobalHelpers.postRequestGeneral.getdata(surveyList(), "120002", UriAdresses.geregeMedtech);
    ereklog.wtf(data);
    surveyListbody = SurveyListBody.fromJson(jsonDecode(data.toString()));
     switch(surveyListbody.code){
       case 200:
          Get.toNamed(RouteUnits.surveyList, arguments: "");
                  GlobalHelpers.bottomnavbarSwitcher.add(true);
          Get.snackbar('Амжилттай', 'Судалгаануудыг амжилттай авлаа!', snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white, backgroundColor: Colors.grey[900], margin: EdgeInsets.only(bottom: GeneralMeasurements.snackbarBottomMargin, left: 5, right: 5,));
          break;
        default : break;  
    }
  }
  Future surveyQuestionsGet() async{
    var jsondata = await GlobalHelpers.postRequestGeneral.getdata(queryPayload(), "120003", UriAdresses.geregeMedtech);
    ereklog.wtf(jsondata);
    queryQuestions = SurveyQuestions.fromJson(jsonDecode(jsondata.toString()));
    for(int i = 0; i< queryQuestions.result!.questions!.length; i++){
      ereklog.i(queryQuestions.result!.questions![i].questionText);
      if(queryQuestions.result!.questions![i].options != null){
         for(int a = 0; a<queryQuestions.result!.questions![i].options!.length; a++){
        ereklog.wtf(queryQuestions.result!.questions![i].options![a].optionText);
      }
      }
    }
    Get.toNamed(RouteUnits.surveyList + RouteUnits.individualSurvey, arguments: "");
    // Get.toNamed(RouteUnits.answerform);
    GlobalHelpers.bottomnavbarSwitcher.add(false);
    surveyAnswer.answers = List<Answers>.generate(queryQuestions.result!.questions!.length, ((index) => Answers()));
  }

  Future surveyAnswersPush() async{//message code deeree toglood olon torliin asuultuud yavuulj bolno
     var jsondata = await GlobalHelpers.postRequestGeneral.getdata(surveyAnswer.toJson(), "120004", UriAdresses.geregeMedtech);
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
          surveyQuestionsGet();
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
            Get.find<LoginController>().geregeUserLogin((){isResearcherAuth();});
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
            Get.find<LoginController>().geregeUserLogin((){Get.find<SurveyController>().researcherDefaultDataUpdateAndPush();});
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
            Get.find<LoginController>().geregeUserLogin((){xyrInfoGet();});
          }
          else{
          Get.snackbar('Аюултай!!', 'Программаа дахин оруулна уу!. Хэрвээ уг алдаа дахин гарвал харилцагчийн төвд хандана уу.', snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white, backgroundColor: Colors.grey[900], margin: EdgeInsets.only(bottom: GeneralMeasurements.snackbarBottomMargin, left: 5, right: 5,));
          }
        break;
    }
  }


  Future backendtest() async{
    var jsonData = await GlobalHelpers.postRequestGeneral.getdata(surveyCreationbody.toJson(), "120001", UriAdresses.geregeMedtech);
    print('json data');
    ereklog.wtf(jsonData);
    generalResponse = GeneralResponse.fromJson(jsonDecode(jsonData));
    log(generalResponse.result.toString());
    switch(generalResponse.code){
      case '200':
          ereklog.wtf('surveyQuestionPush deer 200 toi response irsen');
          GlobalHelpers.workingWithCode.clearSurveyData();
          break;
    }
  }
}