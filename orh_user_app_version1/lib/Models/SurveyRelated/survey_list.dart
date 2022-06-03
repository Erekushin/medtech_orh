import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SurveyListBody {
  int? code;
  String? status;
  String? message;
  Result? result;

  SurveyListBody({this.code, this.status, this.message, this.result});

  SurveyListBody.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    message = json['message'];
    result =
        json['result'] != null ? Result.fromJson(json['result']) : null;
  }
}

class Result {
  List<Items>? items = <Items>[].obs;

  Result({this.items});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
  }
}

class Items {
  int? id;
  String? name;
  var borderColor = Colors.white.obs;

  Items({this.id, this.name});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}