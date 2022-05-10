
import 'dart:convert';
import 'package:get/get.dart';
import 'package:orh_user_app_version1/Controllers/survey_controller.dart';

import '../Helpers/load_json_from_assest.dart';
import '../Models/SurveyRelated/survey_answer_body.dart';
import '../Models/SurveyRelated/survey_question_body.dart';

class CalculatorController{
  SurveyQuestions indicatorQuestions = SurveyQuestions();
  var surveyController = Get.find<SurveyController>();

  Future getIndicatorQuestionList() async {
    String jsonString = await loadFromAsset("assets/file/BMI_question.json");
    var bmiQuestion = jsonDecode(jsonString);
    indicatorQuestions = SurveyQuestions.fromJson(bmiQuestion);
    surveyController.surveyAnswer.answers = List<Answers>.generate(indicatorQuestions.result!.questions!.length, ((index) => Answers()));
  }
  //survey controller oos survey answer dotor hadaglagdsan utguudaa avaad helpers dotor bichsen tvvhii bodoltuudaasaa ashiglaad 
  //hariug bodoj gargah
  bodyMassCalculate(){
    Answers mass = surveyController.surveyAnswer.answers!.map((item) => item.questionId == 'mass') as Answers;
    Answers height = surveyController.surveyAnswer.answers!.map((item) => item.questionId == 'height') as Answers;
    int massInt = int.parse(mass.answerText!);
    int heightInt = int.parse(mass.answerText!);
    double bmi = massInt/((heightInt*heightInt)*10000);
    return bmi;
  }
}
