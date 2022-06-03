class SurveyCreationTypes {
  int? code;
  String? status;
  String? message;
  Result? result;

  SurveyCreationTypes({this.code, this.status, this.message, this.result});

  SurveyCreationTypes.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    message = json['message'];
    result =
        json['result'] != null ? new Result.fromJson(json['result']) : null;
  }
}

class Result {
  List<TypeInfo>? privacyLevel;
  List<TypeInfo>? questionType;
  List<TypeInfo>? surveyType;

  Result({this.privacyLevel, this.questionType, this.surveyType});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['privacy_level'] != null) {
      privacyLevel = <TypeInfo>[];
      json['privacy_level'].forEach((v) {
        privacyLevel!.add(new TypeInfo.fromJson(v));
      });
    }
    if (json['question_type'] != null) {
      questionType = <TypeInfo>[];
      json['question_type'].forEach((v) {
        questionType!.add(new TypeInfo.fromJson(v));
      });
    }
    if (json['survey_type'] != null) {
      surveyType = <TypeInfo>[];
      json['survey_type'].forEach((v) {
        surveyType!.add(new TypeInfo.fromJson(v));
      });
    }
  }
}

class TypeInfo {
  String? typeName;
  int? typeId;

  TypeInfo({this.typeName, this.typeId});

  TypeInfo.fromJson(Map<String, dynamic> json) {
    typeName = json['type_name'];
    typeId = json['type_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type_name'] = this.typeName;
    data['type_id'] = this.typeId;
    return data;
  }
}