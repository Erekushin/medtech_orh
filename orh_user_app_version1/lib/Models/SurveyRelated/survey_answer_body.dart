class QueryAnswer {
  String? regNo = '';
  String? researcherGeregeID = '';
  String? aimagCode = '';
  String? aimagName = '';
  String? sumCode = '';
  String? sumName = '';
  String? fistName = '';
  String? lastName = '';
  String? age = '';
  String? gender = '';
  String? surveyId = '';
  List<Answers>? answers = [];

  QueryAnswer(
      {this.regNo,
      this.researcherGeregeID,
      this.aimagCode,
      this.aimagName,
      this.sumCode,
      this.sumName,
      this.fistName,
      this.lastName,
      this.age,
      this.gender,
      this.surveyId,
      this.answers});

  QueryAnswer.fromJson(Map<String, dynamic> json) {
    regNo = json['reg_no'];
    researcherGeregeID = json['researcher_GeregeID'];
    aimagCode = json['aimag_code'];
    aimagName = json['aimag_name'];
    sumCode = json['sum_code'];
    sumName = json['sum_name'];
    fistName = json['fist_name'];
    lastName = json['last_name'];
    age = json['age'];
    gender = json['gender'];
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
    data['reg_no'] = regNo;
    data['researcher_GeregeID'] = researcherGeregeID;
    data['aimag_code'] = aimagCode;
    data['aimag_name'] = aimagName;
    data['sum_code'] = sumCode;
    data['sum_name'] = sumName;
    data['fist_name'] = fistName;
    data['last_name'] = lastName;
    data['age'] = age;
    data['gender'] = gender;
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

