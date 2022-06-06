class ResponseAnswersbody {
  int? code;
  String? status;
  String? message;
  Result? result;

  ResponseAnswersbody({this.code, this.status, this.message, this.result});

  ResponseAnswersbody.fromJson(Map<String, dynamic> json) {
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
  List<ResponseAnswers>? answers;

  Result({this.answers});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['answers'] != null) {
      answers = <ResponseAnswers>[];
      json['answers'].forEach((v) {
        answers!.add(ResponseAnswers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (answers != null) {
      data['answers'] = answers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ResponseAnswers {
  String? question;
  String? textAnswer;
  String? optionAnswer;

  ResponseAnswers({this.question, this.textAnswer, this.optionAnswer});

  ResponseAnswers.fromJson(Map<String, dynamic> json) {
    question = json['question'];
    textAnswer = json['text_answer'];
    optionAnswer = json['option_answer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['question'] = question;
    data['text_answer'] = textAnswer;
    data['option_answer'] = optionAnswer;
    return data;
  }
}