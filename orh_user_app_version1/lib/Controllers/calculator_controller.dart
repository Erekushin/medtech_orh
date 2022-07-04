
import 'dart:convert';
import 'package:get/get.dart';
import 'package:orh_user_app_version1/Controllers/SurveyRelated/survey_controller.dart';
import 'package:orh_user_app_version1/global_helpers.dart';

import '../Helpers/load_json_from_assest.dart';
import '../Models/SurveyRelated/survey_answer_body.dart';
import '../Models/SurveyRelated/survey_body.dart';

class CalculatorController extends GetxController{
  Survey indicatorQuestions = Survey();
  var surveyController = Get.find<SCont>();
  
  //tvr obs uud............................
  var bodymassindex = '0'.obs;
  //.......................................



  Future getIndicatorQuestionList() async { 
    String jsonString = await loadFromAsset("assets/file/BMI_question.json");
    var bmiQuestion = jsonDecode(jsonString);
    indicatorQuestions = Survey.fromJson(bmiQuestion);
    surveyController.surveyAnswer.answers = List<Answers>.generate(indicatorQuestions.result!.questions!.length, ((index) => Answers()));
  }
  bodyMassCalculate(){
    Answers mass = surveyController.surveyAnswer.answers![0];
    Answers height = surveyController.surveyAnswer.answers![1];
    int massInt = int.parse(mass.answerText!);
    int heightInt = int.parse(height.answerText!);
    double bmi = (massInt/(heightInt*heightInt))*10000;
    bodymassindex.value = bmi.toString().substring(0, 5);
    GlobalHelpers.workingWithCode.clearSurveyAnswers();
  }
}
