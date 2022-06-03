import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SurveyCreationbody {
  String? surveyName;
  int? userId;
  int? surveyType;
  int? surveyPrivacyLevel;
  String? surveyClr = '0xFFFFFFFF';
  String surveyCreatedDate = DateTime.now().toString().substring(0, 10);
  List<Researchers>? researchers;
  List<Question>? questions;

  SurveyCreationbody({this.surveyName, this.questions, this.researchers, this.userId, 
                       this.surveyType, this.surveyPrivacyLevel,
                       this.surveyClr});
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['survey_name'] = surveyName;
    data['user_id'] = userId;
    data['survey_type'] = surveyType;
    data['survey_privacy_level'] = surveyPrivacyLevel;
    data['survey_color'] = surveyClr;
    data['survey_created_date'] = surveyCreatedDate;
    if (questions != null) {
      data['questions'] = questions!.map((v) => v.toJson()).toList();
    }
    if (researchers != null) {
      data['researchers'] = researchers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Researchers{

   String? researcherId;
   Researchers({this.researcherId});
   Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['researcherId'] = researcherId;
    return data;
  }
}


class Question{
  String? questionText;
  String? type;
  List<CreationOptions> options = <CreationOptions>[].obs;
  List<TextEditingController> optionTextController = <TextEditingController>[];
  double? containerHeight;

  Question({this.questionText, this.type,required this.options});
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['question_text'] = questionText;
    data['type'] = type;
    if (options != null) {
      data['options'] = options.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CreationOptions {
  int? id;
  String? optionText;
  CreationOptions({this.id, this.optionText});
  CreationOptions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    optionText = json['option_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['option_text'] = optionText;
    return data;
  }
}