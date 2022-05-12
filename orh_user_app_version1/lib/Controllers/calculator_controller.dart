
import 'dart:convert';
import 'package:get/get.dart';
import 'package:orh_user_app_version1/Controllers/survey_controller.dart';

import '../Helpers/load_json_from_assest.dart';
import '../Models/SurveyRelated/survey_answer_body.dart';
import '../Models/SurveyRelated/survey_question_body.dart';

class CalculatorController extends GetxController{
  SurveyQuestions indicatorQuestions = SurveyQuestions();
  var surveyController = Get.find<SurveyController>();
  
  //tvr obs uud............................
  var bodymassindex = '0'.obs;
  //.......................................



  Future getIndicatorQuestionList() async { 
    String jsonString = await loadFromAsset("assets/file/BMI_question.json");
    var bmiQuestion = jsonDecode(jsonString);
    indicatorQuestions = SurveyQuestions.fromJson(bmiQuestion);
    surveyController.surveyAnswer.answers = List<Answers>.generate(indicatorQuestions.result!.questions!.length, ((index) => Answers()));
  }
  //survey controller oos survey answer dotor hadaglagdsan utguudaa avaad helpers dotor bichsen tvvhii bodoltuudaasaa ashiglaad 
  //hariug bodoj gargah
  bodyMassCalculate(){
    var mass = surveyController.surveyAnswer.answers!.where((item) => item.questionId == 'mass');
    var height = surveyController.surveyAnswer.answers!.where((item) => item.questionId == 'height');
    Answers massItem = mass.first;
    Answers heightItem = height.first;
    int massInt = int.parse(massItem.answerText!);
    int heightInt = int.parse(heightItem.answerText!);
    double bmi = (massInt/(heightInt*heightInt))*10000;
    bodymassindex.value = bmi.toString().substring(0, 5);
  }
}
