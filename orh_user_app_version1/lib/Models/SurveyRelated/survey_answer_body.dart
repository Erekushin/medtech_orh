class SurveyAnswer {
  int? researcherGeregeID ;
  int? surveyId;
  List<Answers>? answers = [];

  SurveyAnswer(
      {this.surveyId,
      this.answers});

  SurveyAnswer.fromJson(Map<String, dynamic> json) {
    researcherGeregeID = json['researcher_GeregeID'];
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
    if (answers != null) {
      data['answers'] = answers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Answers {
  int? questionId;
  int? optionId;
  String? answerText;

  Answers({this.questionId, this.optionId, this.answerText});

  Answers.fromJson(Map<String, dynamic> json) {
    questionId = json['question_id'];
    optionId = json['option_id'];
    answerText = json['answer_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['question_id'] = questionId;
    data['option_id'] = optionId;
    data['answer_text'] = answerText;
    return data;
  }
}

