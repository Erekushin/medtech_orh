class GeneralResponse{
  String? code;
  String? status;
  String? message;
  Result? result;
  GeneralResponse({this.code, this.status, this.message, this.result});
  GeneralResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'].toString();
    status = json['status'];
    message = json['message'];
    result =
        json['result'] != null ? new Result.fromJson(json['result']) : null;
  }
}
class Result{
  String? resultMessage;
  Result.fromJson(Map<String, dynamic> json) {
    resultMessage = json['instance'];
  }
}