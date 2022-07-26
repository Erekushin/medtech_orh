import 'dart:async';
import 'package:get/get.dart';
import 'package:orh_user_app_version1/Controllers/SurveyRelated/survey_controller.dart';
import 'package:orh_user_app_version1/Controllers/auth_controller.dart';
import 'dart:convert';
import 'package:orh_user_app_version1/Helpers/logging.dart';
import 'package:orh_user_app_version1/Models/SurveyRelated/statistic_answer.dart'
    as staAns;
import 'package:orh_user_app_version1/global_helpers.dart';
import '../../Models/SurveyRelated/researchers.dart';
import '../../Models/SurveyRelated/response.dart';
import '../../Models/SurveyRelated/response_answers.dart';
import '../../Models/general_response.dart';
import '../../global_constant.dart';

class ResCont extends GetxController {
  var ereklog = logger(ResCont);
  var chosenSurveyId;
  Map<String, dynamic> chosen(String createdDate, String username) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['survey_id'] = '$chosenSurveyId';
    data['user_id'] = Get.find<AuthController>().user.result!.userId;
    data['created_date'] = createdDate;
    data['user_name'] = username;
    return data;
  }

  SurveyResponsebody surveyResponses = SurveyResponsebody();
  Future responses(String username) async {
    var data = await GlobalHelpers.postRequestGeneral
        .getdata(chosen('', username), "120008", UriAdresses.medCore);
    ereklog.wtf(data);
    surveyResponses = SurveyResponsebody.fromJson(jsonDecode(data.toString()));
    switch (surveyResponses.code) {
      case 200:
        await sta();
        Get.toNamed(RouteUnits.surveyResponses);
        break;
    }
  }

  EResponse respondResearcherGen = EResponse();
  RLst surveyRLst = RLst();
  Future researchers(int chosenIndx, String route) async {
    var data = await GlobalHelpers.postRequestGeneral
        .getdata(chosen('', ''), "120011", UriAdresses.medCore);
    respondResearcherGen = EResponse.fromJson(jsonDecode(data.toString()));
    ereklog.wtf(data);
    respondResearcherGen.result ??= [];
    switch (respondResearcherGen.code) {
      case '200':
        surveyRLst = RLst.fromJson(respondResearcherGen.result);
        Get.toNamed(RouteUnits.respondResearchers);
        switch (route) {
          case "/profile":
            surveyRLst = RLst.fromJson(respondResearcherGen.result);
            Get.toNamed(RouteUnits.respondResearchers);
            Get.find<SCont>()
                .ownSurveyListbody
                .value
                .result![chosenIndx]
                .loading
                .value = false;
            break;
          case "/attachedList":
            Get.find<SCont>()
                .attachedList
                .value
                .result![chosenIndx]
                .loading
                .value = false;
            break;
        }
        break;
    }
  }

  ResponseAnswersbody responseAnswers = ResponseAnswersbody();
  Future answers(String createdDate) async {
    var data = await GlobalHelpers.postRequestGeneral
        .getdata(chosen(createdDate, ''), '120010', UriAdresses.medCore);
    responseAnswers = ResponseAnswersbody.fromJson(jsonDecode(data.toString()));
    switch (responseAnswers.code) {
      case 200:
        Get.toNamed(RouteUnits.surveyResponses + RouteUnits.responseAnswers);
        break;
    }
  }

  staAns.Statistic statisticAnswer = staAns.Statistic();
  List<staAns.Result> lineChartValueList = [];
  Future sta() async {
    var data = await GlobalHelpers.postRequestGeneral
        .getdata(surveyResponses.toJson(), '120100', UriAdresses.medCore);
    ereklog.wtf(surveyResponses.toJson());
    ereklog.wtf(data);
    statisticAnswer = staAns.Statistic.fromJson(jsonDecode(data.toString()));
  }
}
