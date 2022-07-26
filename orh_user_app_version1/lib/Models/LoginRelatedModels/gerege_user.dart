class UserInfo {
  int? code;
  String? status;
  String? message;
  Result? result;

  UserInfo({this.code, this.status, this.message, this.result});

  UserInfo.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    message = json['message'];
    result = json['result'] != null ? Result.fromJson(json['result']) : null;
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
  int? userId;
  String? userName;
  List<dynamic>? picture;
  String? phone;
  Result({this.userId, this.picture, this.userName, this.phone});

  Result.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userName = json['user_name'];
    picture = json['picture'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['user_name'] = userName;
    data['picture'] = picture;
    data['phone'] = phone;
    return data;
  }
}
