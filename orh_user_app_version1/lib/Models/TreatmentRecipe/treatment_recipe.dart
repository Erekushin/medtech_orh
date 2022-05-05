class TreatmentRecipies {
  int? code;
  String? status;
  String? message;
  Result? result;

  TreatmentRecipies({this.code, this.status, this.message, this.result});

  TreatmentRecipies.fromJson(Map<String, dynamic> json) {
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
  List<Recipies>? recipies;

  Result({this.title, this.recipies});

  Result.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    if (json['recipies'] != null) {
      recipies = <Recipies>[];
      json['recipies'].forEach((v) {
        recipies!.add(new Recipies.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    if (this.recipies != null) {
      data['recipies'] = this.recipies!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Recipies {
  int? recipeid;
  String? text;
  int? color;
  String? title;
  String? dateStart;
  String? dateEnd;
  String? picture;
  String? personId;

  Recipies({this.recipeid, this.text, this.color, this.title, this.dateStart,
            this.dateEnd, this.picture, this.personId});

  Recipies.fromJson(Map<String, dynamic> json) {
    recipeid = json['id'];
    text = json['text'];
    color = json['color'];
    title = json['title'];
    dateStart = json['dateStart'];
    dateEnd = json['dateEnd'];
    picture = json['picture'];
    personId = json[' '];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = recipeid;
    data['text'] = text;
    data['color'] = color;
    data['title'] = title;
    data['dateStart'] = dateStart;
    data['dateEnd'] = dateEnd;
    data['picture'] = picture;
    data['personId'] = personId;
    return data;
  }
}