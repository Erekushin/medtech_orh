class GeregeUser {
  int? code;
  String? status;
  String? message;
  Result? result;

  GeregeUser({this.code, this.status, this.message, this.result});

  GeregeUser.fromJson(Map<String, dynamic> json) {
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
  String? id;
  String? phoneNo;
  String? firstName;
  String? lastName;
  String? familyName;
  String? regNo;
  String? civilId;
  String? userName;
  String? birthDate;
  String? email;
  int? gender;
  String? address;
  int? driveExp;
  Null? geregeCard;
  String? accountNo;
  Null? driverLicenseNumber;
  Null? profileImageUrl;
  int? isPin;
  int? isEmailActivated;
  int? isPhoneActivated;
  String? countryCode;
  String? countryName;
  String? aimagCode;
  String? aimagName;
  String? sumCode;
  String? sumName;
  String? bagCode;
  String? bagName;
  int? isXypSync;
  String? expireDate;
  String? issueDate;
  Null? picture;
  int? age;
  Token? token;

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
      this.email,
      this.gender,
      this.address,
      this.driveExp,
      this.geregeCard,
      this.accountNo,
      this.driverLicenseNumber,
      this.profileImageUrl,
      this.isPin,
      this.isEmailActivated,
      this.isPhoneActivated,
      this.countryCode,
      this.countryName,
      this.aimagCode,
      this.aimagName,
      this.sumCode,
      this.sumName,
      this.bagCode,
      this.bagName,
      this.isXypSync,
      this.expireDate,
      this.issueDate,
      this.picture,
      this.age,
      this.token});

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
    email = json['email'];
    gender = json['gender'];
    address = json['address'];
    driveExp = json['drive_exp'];
    geregeCard = json['gerege_card'];
    accountNo = json['account_no'];
    driverLicenseNumber = json['driver_license_number'];
    profileImageUrl = json['profile_image_url'];
    isPin = json['is_pin'];
    isEmailActivated = json['is_email_activated'];
    isPhoneActivated = json['is_phone_activated'];
    countryCode = json['country_code'];
    countryName = json['country_name'];
    aimagCode = json['aimag_code'];
    aimagName = json['aimag_name'];
    sumCode = json['sum_code'];
    sumName = json['sum_name'];
    bagCode = json['bag_code'];
    bagName = json['bag_name'];
    isXypSync = json['is_xyp_sync'];
    expireDate = json['expire_date'];
    issueDate = json['issue_date'];
    picture = json['picture'];
    age = json['age'];
    token = json['token'] != null ? new Token.fromJson(json['token']) : null;
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
    data['email'] = this.email;
    data['gender'] = this.gender;
    data['address'] = this.address;
    data['drive_exp'] = this.driveExp;
    data['gerege_card'] = this.geregeCard;
    data['account_no'] = this.accountNo;
    data['driver_license_number'] = this.driverLicenseNumber;
    data['profile_image_url'] = this.profileImageUrl;
    data['is_pin'] = this.isPin;
    data['is_email_activated'] = this.isEmailActivated;
    data['is_phone_activated'] = this.isPhoneActivated;
    data['country_code'] = this.countryCode;
    data['country_name'] = this.countryName;
    data['aimag_code'] = this.aimagCode;
    data['aimag_name'] = this.aimagName;
    data['sum_code'] = this.sumCode;
    data['sum_name'] = this.sumName;
    data['bag_code'] = this.bagCode;
    data['bag_name'] = this.bagName;
    data['is_xyp_sync'] = this.isXypSync;
    data['expire_date'] = this.expireDate;
    data['issue_date'] = this.issueDate;
    data['picture'] = this.picture;
    data['age'] = this.age;
    if (this.token != null) {
      data['token'] = this.token!.toJson();
    }
    return data;
  }
}

class Token {
  String? token;
  String? expires;
  int? expiresIn;

  Token({this.token, this.expires, this.expiresIn});

  Token.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    expires = json['expires'];
    expiresIn = json['expires_in'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['expires'] = this.expires;
    data['expires_in'] = this.expiresIn;
    return data;
  }
}