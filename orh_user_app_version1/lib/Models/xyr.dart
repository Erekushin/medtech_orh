class XyrInfo {
  String? code;
  String? status;
  String? message;
  Result? result;

  XyrInfo({this.code, this.status, this.message, this.result});

  XyrInfo.fromJson(Map<String, dynamic> json) {
    code = json['code'].toString();
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
  String? id;
  String? phoneNo;
  String? firstName;
  String? lastName;
  String? familyName;
  String? regNo;
  String? civilId;
  String? userName;
  String? birthDate;
  String? age;
  String? email;
  String? address;
  int? driveExp;
  Null? geregeCard;
  int? accountNo;
  String? aimagCode;
  String? sumCode;
  String? bagCode;
  Null? driverLicenseNumber;
  Null? driverLicenseNumber1;
  String? zipcode;
  int? gender;
  Null? picture;

  Result(
      {this.id,
      this.phoneNo,
      this.firstName,
      this.lastName,
      this.familyName,
      this.regNo,
      this.civilId,
      this.userName,
      this.birthDate,
      this.age,
      this.email,
      this.address,
      this.driveExp,
      this.geregeCard,
      this.accountNo,
      this.aimagCode,
      this.sumCode,
      this.bagCode,
      this.driverLicenseNumber,
      this.driverLicenseNumber1,
      this.zipcode,
      this.gender,
      this.picture});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phoneNo = json['phone_no'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    familyName = json['family_name'];
    regNo = json['reg_no'];
    civilId = json['civil_id'];
    userName = json['user_name'];
    birthDate = json['birth_date'];
    age = json['age'];
    email = json['email'];
    address = json['address'];
    driveExp = json['drive_exp'];
    geregeCard = json['gerege_card'];
    accountNo = json['account_no'];
    aimagCode = json['aimag_code'];
    sumCode = json['sum_code'];
    bagCode = json['bag_code'];
    driverLicenseNumber = json['driver_license_number'];
    driverLicenseNumber1 = json['driver_license_number1'];
    zipcode = json['zipcode'];
    gender = json['gender'];
    picture = json['picture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['phone_no'] = this.phoneNo;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['family_name'] = this.familyName;
    data['reg_no'] = this.regNo;
    data['civil_id'] = this.civilId;
    data['user_name'] = this.userName;
    data['birth_date'] = this.birthDate;
    data['age'] = this.age;
    data['email'] = this.email;
    data['address'] = this.address;
    data['drive_exp'] = this.driveExp;
    data['gerege_card'] = this.geregeCard;
    data['account_no'] = this.accountNo;
    data['aimag_code'] = this.aimagCode;
    data['sum_code'] = this.sumCode;
    data['bag_code'] = this.bagCode;
    data['driver_license_number'] = this.driverLicenseNumber;
    data['driver_license_number1'] = this.driverLicenseNumber1;
    data['zipcode'] = this.zipcode;
    data['gender'] = this.gender;
    data['picture'] = this.picture;
    return data;
  }
}