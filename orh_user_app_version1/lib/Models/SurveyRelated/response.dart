class SurveyResponsebody {
  int? code;
  String? status;
  String? message;
  List<Result>? result;

  SurveyResponsebody({this.code, this.status, this.message, this.result});

  SurveyResponsebody.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    message = json['message'];
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(Result.fromJson(v));
      });
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['status'] = status;
    data['message'] = message;
    if (result != null) {
      data['result'] = result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  String? researcherName;
  String? createdDate;
  int? surveyID;
  int? userID;

  Result({this.researcherName, this.createdDate, this.surveyID, this.userID});

  Result.fromJson(Map<String, dynamic> json) {
    researcherName = json['researcher_name'];
    createdDate = json['created_date'];
    surveyID = json['survey_id'];
    userID = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['researcher_name'] = researcherName;
    data['cearted_date'] = createdDate;
    data['survey_id'] = surveyID;
    data['user_id'] = userID;
    return data;
  }
}