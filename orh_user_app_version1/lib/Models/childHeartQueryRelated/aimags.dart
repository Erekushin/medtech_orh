class AimagList {
  List<Aimags>? aimags;

  AimagList({this.aimags});

  AimagList.fromJson(Map<String, dynamic> json) {
    if (json['aimags'] != null) {
      aimags = <Aimags>[];
      json['aimags'].forEach((v) {
        aimags!.add(new Aimags.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.aimags != null) {
      data['aimags'] = this.aimags!.map((v) => v.toJson()).toList();
    }
    return data;
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
        sums!.add(new Sums.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['aimag_code'] = this.aimagCode;
    data['aimag_name'] = this.aimagName;
    data['count'] = this.count;
    if (this.sums != null) {
      data['sums'] = this.sums!.map((v) => v.toJson()).toList();
    }
    return data;
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
        bags!.add(new Bags.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['sum_code'] = this.sumCode;
    data['sum_name'] = this.sumName;
    data['count'] = this.count;
    if (this.bags != null) {
      data['bags'] = this.bags!.map((v) => v.toJson()).toList();
    }
    return data;
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['bag_code'] = this.bagCode;
    data['bag_name'] = this.bagName;
    data['count'] = this.count;
    return data;
  }
}