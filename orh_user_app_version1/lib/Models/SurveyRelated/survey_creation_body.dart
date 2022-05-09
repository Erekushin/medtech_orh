import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SurveyCreationbody {
  String? surveyName;
  List<Question>? questions;

  SurveyCreationbody({this.surveyName, this.questions});
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['survey_name'] = surveyName;
    if (questions != null) {
      data['questions'] = questions!.map((v) => v.toJson()).toList();
    }
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