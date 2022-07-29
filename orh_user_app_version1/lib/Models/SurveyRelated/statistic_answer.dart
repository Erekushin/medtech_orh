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
        result!.add(Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['status'] = status;
    data['message'] = message;
    if (result != null) {
      data['result'] = result!.map((v) => v.toJson()).toList();
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
        answers!.add(StatisticAnswers.fromJson(v));
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

class StatisticAnswers {
  String? question;
  String? textAnswer;
  int? numberAnswer;
  List<OptionAnswers>? optionAnswers;
  String? optionAnswer;
  int? optionId;
  String? createdDate;
  String? astatistic;

  StatisticAnswers(
      {this.question,
      this.textAnswer,
      this.numberAnswer,
      this.optionAnswers,
      this.optionAnswer,
      this.optionId,
      this.createdDate,
      this.astatistic});

  StatisticAnswers.fromJson(Map<String, dynamic> json) {
    question = json['question'];
    textAnswer = json['text_answer'];
    numberAnswer = json['number_answer'];
    if (json['option_answers'] != null) {
      optionAnswers = <OptionAnswers>[];
      json['option_answers'].forEach((v) {
        optionAnswers!.add(OptionAnswers.fromJson(v));
      });
    }
    optionAnswer = json['option_answer'];
    optionId = json['option_id'];
    createdDate = json['created_date'];
    astatistic = json['a_statistic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['question'] = question;
    data['text_answer'] = textAnswer;
    data['number_answer'] = numberAnswer;
    if (optionAnswers != null) {
      data['option_answers'] = optionAnswers!.map((v) => v.toJson()).toList();
    }
    data['option_answer'] = optionAnswer;
    data['option_id'] = optionId;
    data['created_date'] = createdDate;
    data['a_statistic'] = astatistic;
    return data;
  }
}

class OptionAnswers {
  String? optionText;
  int? optionId;

  OptionAnswers({this.optionText, this.optionId});

  OptionAnswers.fromJson(Map<String, dynamic> json) {
    optionText = json['option_text'];
    optionId = json['option_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['option_text'] = this.optionText;
    data['option_id'] = this.optionId;
    return data;
  }
}
