class GeneralResponse{
  String? code;
  String? status;
  String? message;
  var result;
  GeneralResponse({this.code, this.status, this.message, this.result});
  GeneralResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'].toString();
    status = json['status'];
    message = json['message'];
    // result =
    //     json['result'] != null ? GeneralResult.fromJson(json['result']) : null;
  }
}
// class GeneralResult{
//   String? resultMessage;
//   GeneralResult.fromJson(Map<String, dynamic> json) {
//     resultMessage = json['instance'];
//   }
// }