import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:orh_user_app_version1/Controllers/login_controller.dart';
import 'package:orh_user_app_version1/Models/xyr.dart';
import 'package:orh_user_app_version1/global_helpers.dart';
import '../Models/query_answer.dart';
import '../Models/result.dart';
import '../global_constant.dart';
import '../Models/childHeartQueryRelated/aimags.dart';
import '../Models/childHeartQueryRelated/childheartquey.dart';
import '../Models/childHeartQueryRelated/researcherDefault.dart';

class SurveyController extends GetxController {
  //xyr ajillahgvi vyd ajillah textfieldvvdiin controller
  var lastName = TextEditingController();
  var firstName = TextEditingController();
  var age = TextEditingController();
  var gender = TextEditingController();

  List<TextEditingController> textEditingControllers = [];
  ResearcherDefaultData researcherDefaultData = ResearcherDefaultData();
  XyrInfo xyrInfo = XyrInfo();
  QueryQuestions queryQuestions = QueryQuestions();
  QueryAnswer queryAnswer = QueryAnswer();
  GeneralResponse generalResponse = GeneralResponse();
  var rdTxtController = TextEditingController();

  ///songogdson aimagiin id g sonsoh stream
  var chosenAimag = 0.obs;

  ///researcher iin default data bvten bgaa esehiig sonsoh stream
  var haveDefaultData = false.obs;
  var xyrName = ''.obs;
  var childHeartQuerybtnloading = false.obs;
  DateTime currentDate = DateTime.now();
  Future<String> _loadFromAsset() async {
    return await rootBundle.loadString("assets/file/addresses.json");
  }

  Future getAimagList() async {
    String jsonString = await _loadFromAsset();
    var aimagListStr = jsonDecode(jsonString);
    GlobalHelpers.aimagList = AimagList.fromJson(aimagListStr);
  }

  checkData() {
    if (researcherDefaultData.result!.aimagCode != null &&
        researcherDefaultData.result!.sumCode != null &&
        researcherDefaultData.result!.currentDate != null) {
      haveDefaultData.value = true;
    }
  }

  Map<String, dynamic> geregeId() {
    final geregeID = Get.find<LoginController>().geregeUser.result!.id;
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = geregeID;
    return data;
  }

  Map<String, dynamic> queryPayload() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['survey_id'] = '4';
    return data;
  }

  Map<String, dynamic> rd() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['search_text'] = rdTxtController.text;
    return data;
  }

  Future isResearcherAuth() async {
    childHeartQuerybtnloading.value = true;
    var data = await GlobalHelpers.postRequestGeneral
        .getdata(geregeId(), "2035232", UriAdresses.covidBackEnd);
    log(jsonEncode(geregeId()));
    var response = GeneralResponse.fromJson(jsonDecode(data.toString()));
    switch (response.code) {
      case '200':
        childHeartQuerybtnloading.value = false;
        Get.find<SurveyController>().researcherDefaultDataGet();
        Get.find<SurveyController>().surveyQuestionsGet();
        GlobalHelpers.loopCheck = 0;
        break;
      case '100':
        childHeartQuerybtnloading.value = false;
        Get.snackbar('Интернет Алдаа', 'Та интернетээ шалгана уу!',
            snackPosition: SnackPosition.BOTTOM,
            colorText: Colors.white,
            backgroundColor: Colors.grey[900],
            margin: EdgeInsets.only(
              bottom: GeneralMeasurements.snackbarBottomMargin,
              left: 5,
              right: 5,
            ));
        break;
      case '101':
        childHeartQuerybtnloading.value = false;
        Get.snackbar('Интернет Алдаа', 'Та интернетээ шалгана уу!',
            snackPosition: SnackPosition.BOTTOM,
            colorText: Colors.white,
            backgroundColor: Colors.grey[900],
            margin: EdgeInsets.only(
              bottom: GeneralMeasurements.snackbarBottomMargin,
              left: 5,
              right: 5,
            ));
        break;
      case '400':
        childHeartQuerybtnloading.value = false;
        Get.defaultDialog(
            title: 'Таньд судалгаа авах эрх үүсээгүй байна',
            content: Image.asset('assets/images/thinkingBoy.png'));
        break;
      case 'Unauthorized':
        GlobalHelpers.loopCheck++;
        if (GlobalHelpers.loopCheck < 10) {
          Get.find<LoginController>().geregeUserLogin(() {
            isResearcherAuth();
          });
        } else {
          Get.snackbar('Аюултай!!',
              'Программаа дахин оруулна уу!. Хэрвээ уг алдаа дахин гарвал харилцагчийн төвд хандана уу.',
              snackPosition: SnackPosition.BOTTOM,
              colorText: Colors.white,
              backgroundColor: Colors.grey[900],
              margin: EdgeInsets.only(
                bottom: GeneralMeasurements.snackbarBottomMargin,
                left: 5,
                right: 5,
              ));
        }
        break;
      default:
        break;
    }
  }

  Future researcherDefaultDataUpdateAndPush() async {
    var jsondata = await GlobalHelpers.postRequestGeneral.getdata(
        researcherDefaultData.result!.toJson(),
        "2035231",
        UriAdresses.covidBackEnd);
    generalResponse = GeneralResponse.fromJson(jsonDecode(jsondata.toString()));
    switch (generalResponse.code) {
      case '200':
        GlobalHelpers.loopCheck = 0;
        break;
      case 'Unauthorized':
        GlobalHelpers.loopCheck++;
        if (GlobalHelpers.loopCheck < 10) {
          Get.find<LoginController>().geregeUserLogin(() {
            Get.find<SurveyController>().researcherDefaultDataUpdateAndPush();
          });
        } else {
          Get.snackbar('Аюултай!!',
              'Программаа дахин оруулна уу!. Хэрвээ уг алдаа дахин гарвал харилцагчийн төвд хандана уу.',
              snackPosition: SnackPosition.BOTTOM,
              colorText: Colors.white,
              backgroundColor: Colors.grey[900],
              margin: const EdgeInsets.all(5));
        }
        break;
    }
  }

  Future xyrInfoGet() async {
    var xyrInfoString = await GlobalHelpers.postRequestGeneral
        .getdata(rd(), "501002", UriAdresses.covidBackEnd);
    xyrInfo = XyrInfo.fromJson(jsonDecode(xyrInfoString.toString()));
    log(jsonEncode(rd()));
    switch (xyrInfo.code) {
      case '200':
        GlobalHelpers.isXyrNull = true;
        Get.snackbar('Иргэний мэдээллийг авлаа', '',
            snackPosition: SnackPosition.BOTTOM,
            colorText: Colors.white,
            backgroundColor: Colors.grey[900],
            margin: EdgeInsets.only(
              bottom: GeneralMeasurements.snackbarBottomMargin,
              left: 5,
              right: 5,
            ));
        xyrName.value = xyrInfo.result!.firstName!;
        GlobalHelpers.loopCheck = 0;
        break;
      case '404':
        GlobalHelpers.isXyrNull = false;
        Get.snackbar('Талбарын мэдээлэл дутуу байна',
            'Судалгаанд оролцогчийн Регистрийн дугаарыг оруулна уу!',
            snackPosition: SnackPosition.BOTTOM,
            colorText: Colors.white,
            backgroundColor: Colors.grey[900],
            margin: EdgeInsets.only(
              bottom: GeneralMeasurements.snackbarBottomMargin,
              left: 5,
              right: 5,
            ));
        break;
      case 'Unauthorized':
        print('unauthorized ruu orson');
        GlobalHelpers.loopCheck++;
        if (GlobalHelpers.loopCheck < 10) {
          Get.find<LoginController>().geregeUserLogin(() {
            xyrInfoGet();
          });
        } else {
          Get.snackbar('Аюултай!!',
              'Программаа дахин оруулна уу!. Хэрвээ уг алдаа дахин гарвал харилцагчийн төвд хандана уу.',
              snackPosition: SnackPosition.BOTTOM,
              colorText: Colors.white,
              backgroundColor: Colors.grey[900],
              margin: EdgeInsets.only(
                bottom: GeneralMeasurements.snackbarBottomMargin,
                left: 5,
                right: 5,
              ));
        }
        break;
    }
  }

  Future surveyAnswersPush() async {
    var jsondata = await GlobalHelpers.postRequestGeneral
        .getdata(queryAnswer.toJson(), "2035233", UriAdresses.covidBackEnd);
    log(jsonEncode(queryAnswer.toJson()));
    print(jsondata.toString() + ' ' + 'hariugaa yavuulsanii hariu');
    generalResponse = GeneralResponse.fromJson(jsonDecode(jsondata));
    switch (generalResponse.code) {
      case '200':
        Get.snackbar('Амжилттай бүртгэгдлээ', '',
            snackPosition: SnackPosition.BOTTOM,
            colorText: Colors.white,
            backgroundColor: Colors.grey[900],
            margin: EdgeInsets.only(
              bottom: GeneralMeasurements.snackbarBottomMargin,
              left: 5,
              right: 5,
            ));
        rdTxtController.clear();
        textEditingControllers.clear();
        lastName.clear();
        firstName.clear();
        age.clear();
        gender.clear();
        xyrName.value = '';
        GlobalHelpers.loopCheck = 0;
        Get.offAllNamed(RouteUnits.home);
        break;
      case '100':
        Get.snackbar('Интернет Алдаа', 'Та интернетээ шалгана уу!',
            snackPosition: SnackPosition.BOTTOM,
            colorText: Colors.white,
            backgroundColor: Colors.grey[900],
            margin: EdgeInsets.only(
              bottom: GeneralMeasurements.snackbarBottomMargin,
              left: 5,
              right: 5,
            ));
        break;
      case '101':
        Get.snackbar('Интернет Алдаа', 'Та интернетээ шалгана уу!',
            snackPosition: SnackPosition.BOTTOM,
            colorText: Colors.white,
            backgroundColor: Colors.grey[900],
            margin: EdgeInsets.only(
              bottom: GeneralMeasurements.snackbarBottomMargin,
              left: 5,
              right: 5,
            ));
        break;
      case 'Unauthorized':
        GlobalHelpers.loopCheck++;
        if (GlobalHelpers.loopCheck < 10) {
          Get.find<LoginController>().geregeUserLogin(() {
            surveyAnswersPush();
          });
        } else {
          Get.snackbar('Аюултай!!',
              'Программаа дахин оруулна уу!. Хэрвээ уг алдаа дахин гарвал харилцагчийн төвд хандана уу.',
              snackPosition: SnackPosition.BOTTOM,
              colorText: Colors.white,
              backgroundColor: Colors.grey[900],
              margin: EdgeInsets.only(
                bottom: GeneralMeasurements.snackbarBottomMargin,
                left: 5,
                right: 5,
              ));
        }
        break;
    }
  }

  Future researcherDefaultDataGet() async {
    var jsondata = await GlobalHelpers.postRequestGeneral
        .getdata(geregeId(), "2035226", UriAdresses.covidBackEnd);
    researcherDefaultData =
        ResearcherDefaultData.fromJson(jsonDecode(jsondata.toString()));
    researcherDefaultData.result!.currentDate =
        currentDate.toString().substring(0, 10);
    switch (researcherDefaultData.code) {
      case 100:
        Get.snackbar('Интернет Алдаа', 'Та интернетээ шалгана уу!',
            snackPosition: SnackPosition.BOTTOM,
            colorText: Colors.white,
            backgroundColor: Colors.grey[900],
            margin: const EdgeInsets.only(left: 5, top: 5, bottom: 75));
        break;
      case 101:
        Get.snackbar('Интернет Алдаа', 'Та интернетээ шалгана уу!',
            snackPosition: SnackPosition.BOTTOM,
            colorText: Colors.white,
            backgroundColor: Colors.grey[900],
            margin: EdgeInsets.only(
              bottom: GeneralMeasurements.snackbarBottomMargin,
              left: 5,
              right: 5,
            ));
        break;
      default:
        break;
    }
  }

  Future surveyQuestionsGet() async {
    var jsondata = await GlobalHelpers.postRequestGeneral
        .getdata(queryPayload(), "2035225", UriAdresses.covidBackEnd);
    queryQuestions = QueryQuestions.fromJson(jsonDecode(jsondata.toString()));
    Get.toNamed(RouteUnits.queries + RouteUnits.individualQuery, arguments: "");
    GlobalHelpers.bottomnavbarSwitcher.add(false);
    queryAnswer.answers = List<Answers>.generate(
        queryQuestions.result!.questions!.length, ((index) => Answers()));
  }
}
