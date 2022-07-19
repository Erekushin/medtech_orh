class EResponse{
  String? code;
  String? status;
  String? message;
  var result;
  EResponse({this.code, this.status, this.message,this.result});
  EResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'].toString();
    status = json['status'];
    message = json['message'];
    result = json['result'];
  }
}
// class GeneralResult{
//   String? resultMessage;
//   GeneralResult.fromJson(Map<String, dynamic> json) {
//     resultMessage = json['instance'];
//   }
// }