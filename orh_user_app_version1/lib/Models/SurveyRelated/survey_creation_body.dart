import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:orh_user_app_version1/Models/SurveyRelated/survey_creation_types.dart';

class SurveyCreationbody {
  String? surveyName;
  int? userId;
  int? surveyType;
  int? surveyPrivacyLevel;
  String? surveyClr;
  String surveyCreatedDate = DateTime.now().toString().substring(0, 10);
  List<Researchers>? researchers;
  List<Question>? questions;

  SurveyCreationbody({this.surveyName, this.questions, this.researchers, this.userId, 
                       this.surveyType, this.surveyPrivacyLevel,
                       this.surveyClr});
    SurveyCreationbody.fromJson(Map<String, dynamic> json) {
    surveyName = json['survey_name'];
    userId = json['user_id'];
    surveyType = json['survey_type'];
    surveyPrivacyLevel = json['survey_privacy_level'];
    surveyClr = json['survey_color'];
    surveyCreatedDate = json['survey_created_date'];
    if (json['questions'] != null) {
      questions = <Question>[];
      json['questions'].forEach((v) {
        questions!.add(Question.fromJson(v));
      });
    }
    if (json['researchers'] != null) {
      researchers = <Researchers>[];
      json['researchers'].forEach((v) {
        researchers!.add(Researchers.fromJson(v));
      });
    }
  }

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

   String? researcherPhone;
   Researchers({this.researcherPhone});
    Researchers.fromJson(Map<String, dynamic> json) {
    researcherPhone = json['phone'];
  }
   Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phone'] = researcherPhone;
    return data;
  }
}


class Question{
  String? questionText;
  String? type;
  String? statistic;
  List<CreationOptions> options = <CreationOptions>[].obs;
  List<TextEditingController> optionTextController = <TextEditingController>[];
  List<TypeInfo>? questionType;
  List<TypeInfo>? statistics;
  double? containerHeight;

  Question({this.questionText, this.type,required 
            this.options, this.statistic, 
            this.statistics, this.questionType});
    Question.fromJson(Map<String, dynamic> json) {
    questionText = json['question_text'];
    type = json['type'];
    statistic = json['statistic'];
    if (json['options'] != null) {
      options = <CreationOptions>[];
      json['options'].forEach((v) {
        options.add(CreationOptions.fromJson(v));
      });
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['question_text'] = questionText;
    data['type'] = type;
    data['statistic'] = statistic;
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