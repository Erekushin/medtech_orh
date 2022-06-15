class RegisterResponse {
  int? code;
  String? status;
  String? message;
  Result? result;

  RegisterResponse({this.code, this.status, this.message, this.result});

  RegisterResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    message = json['message'];
    result =
        json['result'] != null ? Result.fromJson(json['result']) : null;
  }
}

class Result {
  int? code;
  String? status;
  String? message;

  Result({this.code, this.status, this.message});

  Result.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    message = json['message'];
  }
}