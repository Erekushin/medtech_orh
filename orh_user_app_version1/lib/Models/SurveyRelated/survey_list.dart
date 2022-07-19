import 'package:orh_user_app_version1/Models/SurveyRelated/survey_body.dart';

class SurveyListBody {
  List<Survey>? result;

  SurveyListBody({this.result});

  SurveyListBody.fromJson(List<dynamic> json) {
    result = <Survey>[];
      for (var v in json) {
        result!.add(Survey.fromJson(v));
      }
  }
}