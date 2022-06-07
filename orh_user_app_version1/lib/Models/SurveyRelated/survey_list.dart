import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SurveyListBody {
  int? code;
  String? status;
  String? message;
  List<Result>? result;

  SurveyListBody({this.code, this.status, this.message, this.result});

  SurveyListBody.fromJson(Map<String, dynamic> json) {
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
  String? name;
  int? id;
  int? userId;
  var loading = false.obs;
  var borderColor = Colors.white.obs;

  Result({this.name, this.id, this.userId});

  Result.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    data['user_id'] = this.userId;
    return data;
  }
}