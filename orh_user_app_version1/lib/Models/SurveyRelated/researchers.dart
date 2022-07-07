
class RLst {
  List<Researcher>? result;

  RLst({this.result});

  RLst.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <Researcher>[];
      json['result'].forEach((v) {
        result!.add(Researcher.fromJson(v));
      });
    }
  }
}

class Researcher{
  String? name;
  Researcher({this.name});

  Researcher.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}