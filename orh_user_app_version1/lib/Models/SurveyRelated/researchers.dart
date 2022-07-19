
class RLst {
  List<Researcher>? result;

  RLst({this.result});

  RLst.fromJson(List<dynamic> json) {
     result = <Researcher>[];
      for (var v in json) {
        result!.add(Researcher.fromJson(v));
      }
  }
}

class Researcher{
  String? name;
  Researcher({this.name});

  Researcher.fromJson(Map<String, dynamic> json) {
    name = json['creator_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['creator_name'] = name;
    return data;
  }
}