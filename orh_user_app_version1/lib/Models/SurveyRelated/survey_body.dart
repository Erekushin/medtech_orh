// class Survey {
//   int? code;
//   String? status;
//   String? message;
//   Result? result;

//   Survey({this.code, this.status, this.message, this.result});

//   Survey.fromJson(Map<String, dynamic> json) {
//     code = json['code'];
//     status = json['status'];
//     message = json['message'];
//     result =
//         json['result'] != null ? Result.fromJson(json['result']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['code'] = code;
//     data['status'] = status;
//     data['message'] = message;
//     if (result != null) {
//       data['result'] = result!.toJson();
//     }
//     return data;
//   }
// }

class Survey {
  String? title;
  List<Questions>? questions;

  Survey({this.title, this.questions});

  Survey.fromJson(Map<String, dynamic> json) {
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
  String? statistic;
  List<Options>? options;

  Questions({this.id, this.type, this.questionText, this.options, this.statistic});

  Questions.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    type = json['type'];
    questionText = json['question_text'];
    statistic = json['statistic'];
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options!.add(Options.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['type'] = type;
    data['question_text'] = questionText;
    data['statistic'] = statistic;
    if (options != null) {
      data['options'] = options!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Options {
  int? optionId;
  String? optionText;

  Options({this.optionId, this.optionText});

  Options.fromJson(Map<String, dynamic> json) {
    optionId = json['option_id'];
    optionText = json['option_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['option_id'] = this.optionId;
    data['option_text'] = this.optionText;
    return data;
  }
}