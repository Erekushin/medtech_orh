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
        result!.add(new Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  String? researcherName;
  String? creartedDate;

  Result({this.researcherName, this.creartedDate});

  Result.fromJson(Map<String, dynamic> json) {
    researcherName = json['researcher_name'];
    creartedDate = json['crearted_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['researcher_name'] = this.researcherName;
    data['crearted_date'] = this.creartedDate;
    return data;
  }
}