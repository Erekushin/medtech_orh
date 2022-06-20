import 'package:get/get.dart';
import 'package:orh_user_app_version1/Controllers/SurveyRelated/survey_controller.dart';
import '../Controllers/SurveyRelated/survey_creation_controller.dart';

class WorkingWithCode{
 clearSurveyAnswers(){
  var surveyController = Get.find<SurveyController>();
   surveyController.surveyAnswer.answers?.clear();
   surveyController.textEditingControllers.clear();
   surveyController.dropvalueList.clear();
 }
 clearSurveyCreation(){
  var sCCont = Get.find<CreationCont>();
  sCCont.staTypes.clear();
   sCCont.qTxts.clear();
   sCCont.qTypes.clear();
  sCCont.newQuestionList.clear();
  sCCont.researcherPhoneList.clear();
  sCCont.researchetTextController.clear();
  sCCont.surveyNametxtController.text = '';
  sCCont.torolStr = null;
  sCCont.levelStr = null;
  sCCont.torolNameStr = null;
  sCCont.levelNameStr = null;
  sCCont.toolQuestionCount.value = 0;
  sCCont.surveyCreationbody.surveyClr = '0xFFFFFFFF';
 }
}