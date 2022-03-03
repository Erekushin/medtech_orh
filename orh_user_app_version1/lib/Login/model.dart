class LoginModel {
  static const String uri = "";
  static bool loginloading = false;
  int? code;
  String? status;
  String? message;
  Result? result;

  LoginModel({this.code, this.status, this.message, this.result});
  LoginModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    message = json['message'];
    result =
    json['result'] != null ?  Result.fromJson(json['result']) : null;
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
  String? id;
  String? regNo;
  String? firstName;
  String? lastName;
  String? familyName;
  String? phone;
  String? civilId;
  String? userName;
  String? birthDate;
  int? age;
  String? email;
  String? address;
  int? driveExp;
  String? geregeCard;
  String? accountNo;
  int? gender;
  String? driverLicenseNumber;

  Result(
      {this.id,
        this.regNo,
        this.firstName,
        this.lastName,
        this.familyName,
        this.phone,
        this.civilId,
        this.userName,
        this.birthDate,
        this.age,
        this.email,
        this.address,
        this.driveExp,
        this.geregeCard,
        this.accountNo,
        this.gender,
        this.driverLicenseNumber});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    regNo = json['reg_no'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    familyName = json['family_name'];
    phone = json['phone'];
    civilId = json['civil_id'];
    userName = json['user_name'];
    birthDate = json['birth_date'];
    age = json['age'];
    email = json['email'];
    address = json['address'];
    driveExp = json['drive_exp'];
    geregeCard = json['gerege_card'];
    accountNo = json['account_no'];
    gender = json['gender'];
    driverLicenseNumber = json['driver_license_number'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['reg_no'] = this.regNo;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['family_name'] = this.familyName;
    data['phone'] = this.phone;
    data['civil_id'] = this.civilId;
    data['user_name'] = this.userName;
    data['birth_date'] = this.birthDate;
    data['age'] = this.age;
    data['email'] = this.email;
    data['address'] = this.address;
    data['drive_exp'] = this.driveExp;
    data['gerege_card'] = this.geregeCard;
    data['account_no'] = this.accountNo;
    data['gender'] = this.gender;
    data['driver_license_number'] = this.driverLicenseNumber;
    return data;
  }
}
