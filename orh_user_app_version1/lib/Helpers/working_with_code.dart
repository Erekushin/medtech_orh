import 'package:get/get.dart';
import 'package:orh_user_app_version1/Controllers/SurveyRelated/survey_controller.dart';

import '../Controllers/SurveyRelated/survey_creation_controller.dart';

class WorkingWithCode{
  clearSurveyData(){
  var surveyController = Get.find<SurveyController>();
  surveyController.surveyAnswer.answers?.clear();
  surveyController.textEditingControllers.clear();
  surveyController.dropvalueList.clear();
  var surveyCreationController = Get.find<CreationCont>();
  surveyCreationController.newQuestionList.clear();
  surveyCreationController.researchetIdList.clear();
  surveyCreationController.researchetTextController.clear();
  surveyCreationController.surveyNametxtController.text = '';
  surveyCreationController.torolStr = null;
  surveyCreationController.levelStr = null;
  surveyCreationController.torolNameStr = null;
  surveyCreationController.levelNameStr = null;
  surveyCreationController.toolQuestionCount.value = 0;
  surveyCreationController.surveyCreationbody.surveyClr = '0xFFFFFFFF';
 }
}