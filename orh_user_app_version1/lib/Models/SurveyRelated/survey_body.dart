class Survey {
  int? code;
  String? status;
  String? message;
  Result? result;

  Survey({this.code, this.status, this.message, this.result});

  Survey.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    message = json['message'];
    result =
        json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    return data;
  }
}

class Result {
  String? title;
  List<Questions>? questions;

  Result({this.title, this.questions});

  Result.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    if (json['questions'] != null) {
      questions = <Questions>[];
      json['questions'].forEach((v) {
        questions!.add(new Questions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    if (this.questions != null) {
      data['questions'] = this.questions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Questions {
  String? id;
  int? type;
  String? questionText;
  Null? options;

  Questions({this.id, this.type, this.questionText, this.options});

  Questions.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    type = json['type'];
    questionText = json['question_text'];
    options = json['options'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['question_text'] = this.questionText;
    data['options'] = this.options;
    return data;
  }
}