class BaseData {
  int? code;
  String? status;
  String? message;
  Result? result;
  BaseData({this.code, this.status, this.message, this.result});
  BaseData.fromJson(Map<String, dynamic> json) {
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
  List<Items>? items;
  Result({this.items});
  Result.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class Items {
  int? id;
  String? name;
  String? code;
  int? sequence;
  List<Views>? views;
  Items({this.id, this.name, this.code, this.sequence, this.views});
  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    sequence = json['sequence'];
    if (json['views'] != null) {
      views = <Views>[];
      json['views'].forEach((v) {
        views!.add(new Views.fromJson(v));
      });
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['code'] = this.code;
    data['sequence'] = this.sequence;
    if (this.views != null) {
      data['views'] = this.views!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class Views {
  int? id;
  String? name;
  int? sequence;
  int? groupId;
  String? groupName;
  List<ActionBody>? actions;
  Views(
      {this.id,
        this.name,
        this.sequence,
        this.groupId,
        this.groupName,
        this.actions});
  Views.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    sequence = json['sequence'];
    groupId = json['group_id'];
    groupName = json['group_name'];
    if (json['actions'] != null) {
      actions = <ActionBody>[];
      json['actions'].forEach((v) {
        actions!.add(new ActionBody.fromJson(v));
      });
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['sequence'] = this.sequence;
    data['group_id'] = this.groupId;
    data['group_name'] = this.groupName;
    if (this.actions != null) {
      data['actions'] = this.actions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class ActionBody{
  ActionBody.fromJson(Map<String, dynamic> json) {}
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = "klkl";
    return data;
  }
}