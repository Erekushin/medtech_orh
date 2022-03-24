//TODO json toi ajilladag ilvv deer arga oloh

class LoginModel {
  static const String uri = "";
  int? code;
  String? status;
  String? message;
  Result? result;
  String? terminalID;
  LoginModel({this.code, this.status, this.message, this.result, this.terminalID});
  LoginModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    message = json['message'];
    result =
    json['result'] != null ?  Result.fromJson(json['result']) : null;
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
}
