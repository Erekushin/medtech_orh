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
}

class Result {
  String? name;
  int? id;
  int? userId;
  String? color;
  String? creatorName;
  List<int>? creatorPicture;  
  var loading = false.obs;
  var borderColor = Colors.white.obs;

  Result({this.name, this.id, this.userId, this.creatorName, this.creatorPicture, this.color});

  Result.fromJson(Map<String, dynamic> json) {
    creatorPicture = json['creator_picture'];
    creatorName = json['creator_name'];
    name = json['name'];
    color = json['survey_color'];
    id = json['id'];
    userId = json['user_id'];
  }

}