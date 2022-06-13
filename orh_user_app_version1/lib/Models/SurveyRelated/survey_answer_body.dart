class SurveyAnswer {
  int? researcherGeregeID ;
  String? fillerName;
  int? surveyId;
  String? createdDate;
  List<Answers>? answers = [];

  SurveyAnswer({this.surveyId,this.answers,
                 this.fillerName, this.createdDate});

  SurveyAnswer.fromJson(Map<String, dynamic> json) {
    researcherGeregeID = json['researcher_GeregeID'];
    createdDate = json['created_date'];
    surveyId = json['survey_id'];
    if (json['answers'] != null) {
      answers = <Answers>[];
      json['answers'].forEach((v) {
        answers!.add(Answers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['researcher_GeregeID'] = researcherGeregeID;
    data['survey_id'] = surveyId;
    data['user_name'] = fillerName;
    data['created_date'] = createdDate;
    if (answers != null) {
      data['answers'] = answers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Answers {
  int? questionId;
  int? optionId;
  int? answerDigit;
  String? answerText;
  String? statistic;

  Answers({this.questionId, this.optionId, this.answerText, this.answerDigit, this.statistic});

  Answers.fromJson(Map<String, dynamic> json) {
    questionId = json['question_id'];
    optionId = json['option_id'];
    answerDigit = json['answer_digit'];
    answerText = json['answer_text'];
    statistic = json['statistic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['question_id'] = questionId;
    data['option_id'] = optionId;
    data['answer_digit'] = answerDigit;
    data['answer_text'] = answerText;
    data['statistic'] = statistic;
    return data;
  }
}

