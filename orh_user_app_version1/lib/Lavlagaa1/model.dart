import 'dart:convert';
import 'package:http/http.dart' as http;
class form1Model{
  String? userId;
  String? orgId;
  String? profession;
  String? office;
  int? working_condition;
  String? position;
  String? phone;
  int? reason_not_employment;
  int? employment;
  int? education_situation;
  int? blood_type;
  int? marital_status;
  int? is_disability;
  String? number_families;
  String? nationality;
  int? is_alcohol;
  int? is_cigarette;
  int? is_medicine;
  form1Model({ this.userId = "10210114114317478154",
    this.orgId = "",
    this.profession = "",
    this.office,
    this.working_condition,
    this.position,
    this.phone,
    this.reason_not_employment,
    this.employment,
    this.education_situation,
    this.blood_type,
    this.marital_status,
    this.is_disability,
    this.number_families,
    this.nationality,
    this.is_alcohol,
    this.is_cigarette,
    this.is_medicine,
  }){}
}