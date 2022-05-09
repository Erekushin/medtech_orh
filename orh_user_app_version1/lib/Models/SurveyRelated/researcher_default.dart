
class ResearcherDefaultData {
  int? code;
  String? status;
  String? message;
  Result? result;

  ResearcherDefaultData({this.code, this.status, this.message, this.result});

  ResearcherDefaultData.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    message = json['message'];
    result =
        json['result'] != null ? Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['status'] = status;
    data['message'] = message;
    if (result != null) {
      data['result'] = result!.toJson();
    }
    return data;
  }
}

class Result {
  String? userId;
  String? aimagCode;
  String? sumCode;
  String? bagCode;
  String? aimagName;
  String? sumName;
  String? currentDate;

  Result(
      {this.userId,
      this.aimagCode,
      this.sumCode,
      this.bagCode,
      this.aimagName,
      this.sumName});

  Result.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    aimagCode = json['aimag_code'];
    sumCode = json['sum_code'];
    bagCode = json['bag_code'];
    aimagName = json['aimag_name'];
    sumName = json['sum_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['aimag_code'] = aimagCode;
    data['sum_code'] = sumCode;
    data['bag_code'] = bagCode;
    data['aimag_name'] = aimagName;
    data['sum_name'] = sumName;
    return data;
  }
}