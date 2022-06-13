class Statistic {
  int? code;
  String? status;
  String? message;
  List<Result>? result;

  Statistic({this.code, this.status, this.message, this.result});

  Statistic.fromJson(Map<String, dynamic> json) {
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
  List<StatisticAnswers>? answers;

  Result({this.answers});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['answers'] != null) {
      answers = <StatisticAnswers>[];
      json['answers'].forEach((v) {
        answers!.add(new StatisticAnswers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.answers != null) {
      data['answers'] = this.answers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StatisticAnswers {
  String? question;
  Null? textAnswer;
  int? numberAnswer;
  Null? optionAnswer;

  StatisticAnswers(
      {this.question, this.textAnswer, this.numberAnswer, this.optionAnswer});

  StatisticAnswers.fromJson(Map<String, dynamic> json) {
    question = json['question'];
    textAnswer = json['text_answer'];
    numberAnswer = json['number_answer'];
    optionAnswer = json['option_answer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['question'] = this.question;
    data['text_answer'] = this.textAnswer;
    data['number_answer'] = this.numberAnswer;
    data['option_answer'] = this.optionAnswer;
    return data;
  }
}