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
import '../auth_controller.dart';

class CreationCont extends GetxController {
  final ereklog = logger(CreationCont);
  List<DropSelectVal> qTypes = [];
  List<DropSelectVal> staTypes = [];
  List<TextEditingController> qTxts = [];

  SurveyCreationTypes surveyCreationTypes = SurveyCreationTypes();
  EResponse generalResponse = EResponse();

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

  ///зүгээр асуумж бөглөж байгаа болон auto survey үүсгэж байгаа
  ///эсэхийг илэрхийлэх switcher
  var sSwitcher = false.obs;
  String strCombination = '0';
  List<CombUnit> strCombList = [];

  String? torolStr;
  String? counttypeStr;
  String? levelStr;
  String? torolNameStr;
  String? levelNameStr;

  String? randomString;
  int? slevel = 1;

  ///vvsgej bui Question vvdee hadaglah list
  var newQuestionList = <Questions>[].obs;
  var toolQuestionCount = 0.obs;
  var surveyCreationPageController = PageController();

  Future getSurveyCreationTypes(String route) async {
    var data = await GlobalHelpers.postRequestGeneral
        .getdata({}, '120005', UriAdresses.medCore);
    ereklog.wtf(data);
    surveyCreationTypes =
        SurveyCreationTypes.fromJson(jsonDecode(data.toString()));
    switch (surveyCreationTypes.code) {
      case 200:
        ereklog.wtf('200 irsen shvv');
        SCargubody sCargubody = SCargubody();
        sCargubody.initialPage = 0;
        sCargubody.fromRoute = route;
        Get.toNamed(RouteUnits.surveyCreation, arguments: sCargubody);
    }
  }

  Survey lastS = Survey();
  Survey chosenNodeSurvey = Survey();
  List<Survey> surveys = [];
  Argu arg = Argu();
  List<Survey>? filteredList2;
  findParentNode(int currentlvl) {
    int parentlvl = currentlvl - 1;
    List<Survey> filteredList = [];
    filteredList.add(Survey(connectedid: 0, name: 'dfdfdd'));
    for (int a = 0; a < surveys.length; a++) {
      if (surveys[a].slevel == parentlvl) {
        filteredList.add(surveys[a]);
      }
    }
    filteredList2 = filteredList;
  }

  Future surveyCreate(String key, int idx) async {
    surveyCreationbody.name = surveyNametxtCont.text;
    if (surveyCreationbody.name != null &&
        surveyCreationbody.surveyPrivacyLevel != null &&
        surveyCreationbody.surveyType != null &&
        surveyCreationbody.countType != null) {
      //level, type, color, date 4 songogdoh vydee yavchihaj bgaa
      surveyCreationbody.userId =
          Get.find<AuthController>().user.result!.userId!;
      surveyCreationbody.questions = newQuestionList;
      surveyCreationbody.researchers = researcherPhoneList;
      surveyCreationbody.groupid = randomString!;
      surveyCreationbody.slevel = slevel;

      for (int l = 0; l < strCombList.length; l++) {
        strCombination += strCombList[l].unit!;
      }
      findParentNode(slevel!);
      String a = filteredList2!.last.connectedid.toString() + strCombination;
      surveyCreationbody.connectedid = int.parse(a);

      for (int i = 0; i < surveyCreationbody.questions!.length; i++) {
        surveyCreationbody.questions![i].num = i + 1;
        if (surveyCreationbody.questions![i].options.isNotEmpty) {
          for (int a = 0;
              a < surveyCreationbody.questions![i].options.length;
              a++) {
            surveyCreationbody.questions![i].options[a].num = a + 1;
          }
        }
      }
      /////////////////////////////////
      var jsonData = await GlobalHelpers.postRequestGeneral
          .getdata(surveyCreationbody.toJson(), "120001", UriAdresses.medCore);
      ereklog.wtf(surveyCreationbody.toJson());
      ereklog.wtf(jsonData);
      generalResponse = EResponse.fromJson(jsonDecode(jsonData));
      switch (generalResponse.code) {
        case '200':
          Get.snackbar('Амжилттай', '',
              snackPosition: SnackPosition.BOTTOM,
              colorText: Colors.white,
              backgroundColor: Colors.grey[900],
              margin: const EdgeInsets.all(5));
          GlobalHelpers.workingWithCode.clearSurveyCreation();
          switch (key) {
            case "variationup":
              lastS = Survey.fromJson(generalResponse.result);
              if (lastS.slevel == 1) {
                Get.snackbar(
                    '', 'level 1 бүхий судалгаан дээр хувилбар нэмэх боломжгүй',
                    snackPosition: SnackPosition.BOTTOM,
                    colorText: Colors.white,
                    backgroundColor: Colors.grey[900],
                    margin: const EdgeInsets.all(5));
                Get.offAllNamed(RouteUnits.home);
                break;
              }
              surveys.add(lastS);
              surveyNametxtCont.text = surveys.last.name!;
              slevel = surveys.last.slevel;
              findParentNode(slevel!);
              surveyCreationbody.preconnected = filteredList2!.last.connectedid;

              arg.sColor = surveyCreationbody.surveyClr;
              arg.type = "Auto";
              arg.count = filteredList2!.last.questions!.length;
              arg.key = surveys.indexOf(filteredList2!.last);
              arg.surveylvl = filteredList2!.last.slevel;
              Get.find<SCont>().surveyAnswer.answers = List<Answers>.generate(
                  lastS.questions!.length, ((index) => Answers()));
              strCombList = List<CombUnit>.generate(
                  surveys[surveys.indexOf(surveys.last) - 1].questions!.length,
                  ((index) => CombUnit()));
              Get.toNamed(RouteUnits.surveyList + RouteUnits.individualSurvey,
                  arguments: arg);
              break;
            case "levelup":
              //daraagiin survey niihee yumnuudaas beldej bgaa heseg
              lastS = Survey.fromJson(generalResponse.result);
              surveys.add(lastS);
              surveyNametxtCont.text = surveys.last.name!;
              slevel = surveys.last.slevel! + 1;
              findParentNode(slevel!);
              surveyCreationbody.preconnected = filteredList2!.last.connectedid;
              //combination beldej hariulah heseg rvv yavahdaa beldej bgaa heseg
              arg.sColor = surveyCreationbody.surveyClr;
              arg.type = "Auto";
              arg.count = surveys.last.questions!.length;
              arg.key = surveys.indexOf(surveys.last);
              arg.surveylvl = surveys.last.slevel;
              Get.find<SCont>().surveyAnswer.answers = List<Answers>.generate(
                  lastS.questions!.length, ((index) => Answers()));
              strCombList = List<CombUnit>.generate(
                  surveys[surveys.indexOf(surveys.last)].questions!.length,
                  ((index) => CombUnit()));
              Get.toNamed(RouteUnits.surveyList + RouteUnits.individualSurvey,
                  arguments: arg);
              break;
            case "levelupOnChosen":
              chosenNodeSurvey = surveys.elementAt(idx);
              lastS = Survey.fromJson(generalResponse.result);
              surveys.add(lastS);
              surveyNametxtCont.text = surveys.last.name!;
              slevel = chosenNodeSurvey.slevel! + 1;
              findParentNode(slevel!);
              surveyCreationbody.preconnected = filteredList2!.last.connectedid;

              arg.count = chosenNodeSurvey.questions!.length;
              arg.key = idx;
              arg.surveylvl = chosenNodeSurvey.slevel;
              strCombList = List<CombUnit>.generate(
                  surveys[idx].questions!.length, ((index) => CombUnit()));
              Get.toNamed(RouteUnits.surveyList + RouteUnits.individualSurvey,
                  arguments: arg);
              break;
            case "save":
              slevel = 1;
              surveys = [];
              filteredList2 = [];
              strCombList = [];
              Get.offAllNamed(RouteUnits.home);
              break;
          }
          break;
        case '400':
          Get.snackbar('Судалгааг хадаглаж чадсангүй',
              generalResponse.message.toString(),
              snackPosition: SnackPosition.BOTTOM,
              colorText: Colors.white,
              backgroundColor: Colors.grey[900],
              margin: const EdgeInsets.all(5));
          break;
      }
    } else {
      Get.snackbar('Талбарууд дутуу байна', '',
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          backgroundColor: Colors.grey[900],
          margin: const EdgeInsets.all(5));
    }
  }
}
