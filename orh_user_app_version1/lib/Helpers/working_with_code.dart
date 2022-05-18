import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orh_user_app_version1/Controllers/survey_controller.dart';

class WorkingWithCode{
  clearSurveyData(){
  var surveyController = Get.find<SurveyController>();
  surveyController.surveyAnswer.answers?.clear();
  surveyController.textEditingControllers.clear();
  surveyController.dropvalueList.clear();
  surveyController.newQuestionList.clear();
 }
}