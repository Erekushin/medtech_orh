
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:orh_user_app_version1/Models/SurveyRelated/survey_creation_types.dart';


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

class Survey {
  String? name;
  int? userId;
  int? surveyType;
  int? countType;
  int? surveyPrivacyLevel;
  String? surveyClr;
  String? groupid;
  int? slevel;
  int? connectedid;
  String surveyCreatedDate = DateTime.now().toString().substring(0, 10);
  List<Researchers>? researchers;
  List<Questions>? questions;

  Survey({name, userId, surveyType, countType,
          surveyPrivacyLevel, surveyClr,
          researchers, questions,
          groupid, slevel, connectedid});

  Survey.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    userId = json['user_id'];
    surveyType = json['survey_type'];
    countType = json['count_type'];
    surveyPrivacyLevel = json['survey_privacy_level'];
    surveyClr = json['survey_color'];

    groupid = json["groupid"];
    slevel = json["slevel"];
    connectedid = json["connectedid"];

    surveyCreatedDate = json['survey_created_date']?? '';
    if (json['researchers'] != null) {
      researchers = <Researchers>[];
      json['researchers'].forEach((v) {
        researchers!.add(Researchers.fromJson(v));
      });
    }
    if (json['questions'] != null) {
      questions = <Questions>[];
      json['questions'].forEach((v) {
        questions!.add(Questions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['user_id'] = userId;
    data['survey_type'] = surveyType;
    data['count_type'] = countType;
    data['survey_privacy_level'] = surveyPrivacyLevel;
    data['survey_color'] = surveyClr;

    data['groupid'] = groupid;
    data['slevel'] = slevel;
    data['connectedid'] = connectedid;


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

class Questions {
  String? id;
  int? type;
  String? questionText;
  String? statistic;
  int? num;
  List<Options> options = <Options>[].obs;
  List<TextEditingController> optionTextController = <TextEditingController>[];
  List<TypeInfo>? questionType;
  List<TypeInfo>? statistics;
  double? containerHeight;
  Questions({this.id, this.type, this.questionText, required this.options, 
             this.statistic, this.questionType, this.statistics, this.num});

  Questions.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    type = json['type'];
    questionText = json['question_text'];
    statistic = json['statistic'];
    num = json['num'];
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options.add(Options.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['question_text'] = questionText;
    data['statistic'] = statistic;
    data['num'] = num; 
    if (options != null) {
      data['options'] = options.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Options {
  int? optionId;
  String? optionText;
  int? num;

  Options({this.optionId, this.optionText, this.num});

  Options.fromJson(Map<String, dynamic> json) {
    optionId = json['option_id'];
    optionText = json['option_text']; 
    num = json['num']; }
    

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['option_id'] = optionId;
    data['option_text'] = optionText;
    data['num'] = num;
    return data;
  }
}