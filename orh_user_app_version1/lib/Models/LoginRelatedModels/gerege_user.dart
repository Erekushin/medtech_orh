class User_Info {
  int? code;
  String? status;
  String? message;
  Result? result;

  User_Info({this.code, this.status, this.message, this.result});

  User_Info.fromJson(Map<String, dynamic> json) {
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
  int? userId;
  List<int>? picture;
  Result({this.userId, this.picture});

  Result.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    picture = json['picture'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['picture'] = picture;
    return data;
  }
}