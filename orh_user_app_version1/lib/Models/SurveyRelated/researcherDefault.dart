


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
        json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result!.toJson();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['aimag_code'] = this.aimagCode;
    data['sum_code'] = this.sumCode;
    data['bag_code'] = this.bagCode;
    data['aimag_name'] = this.aimagName;
    data['sum_name'] = this.sumName;
    return data;
  }
}