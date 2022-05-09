class AimagList {
  List<Aimags>? aimags;

  AimagList({this.aimags});

  AimagList.fromJson(Map<String, dynamic> json) {
    if (json['aimags'] != null) {
      aimags = <Aimags>[];
      json['aimags'].forEach((v) {
        aimags!.add(Aimags.fromJson(v));
      });
    }
  }
}

class Aimags {
  String? aimagCode;
  String? aimagName;
  int? count;
  List<Sums>? sums;

  Aimags({this.aimagCode, this.aimagName, this.count, this.sums});

  Aimags.fromJson(Map<String, dynamic> json) {
    aimagCode = json['aimag_code'];
    aimagName = json['aimag_name'];
    count = json['count'];
    if (json['sums'] != null) {
      sums = <Sums>[];
      json['sums'].forEach((v) {
        sums!.add(Sums.fromJson(v));
      });
    }
  }
}

class Sums {
  String? code;
  String? sumCode;
  String? sumName;
  int? count;
  List<Bags>? bags;

  Sums({this.code, this.sumCode, this.sumName, this.count, this.bags});

  Sums.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    sumCode = json['sum_code'];
    sumName = json['sum_name'];
    count = json['count'];
    if (json['bags'] != null) {
      bags = <Bags>[];
      json['bags'].forEach((v) {
        bags!.add(Bags.fromJson(v));
      });
    }
  }
}

class Bags {
  String? code;
  String? bagCode;
  String? bagName;
  int? count;

  Bags({this.code, this.bagCode, this.bagName, this.count});

  Bags.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    bagCode = json['bag_code'];
    bagName = json['bag_name'];
    count = json['count'];
  }
}