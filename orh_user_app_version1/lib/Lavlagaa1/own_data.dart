class OwnData {
  int? code;
  String? status;
  String? message;
  Result? result;

  OwnData({this.code, this.status, this.message, this.result});

  OwnData.fromJson(Map<String, dynamic> json) {
    print('own data iin fromJson dotroos');
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
  int? pageNumber;
  int? pageSize;
  int? totalRow;
  int? totalPage;
  List<Listbody>? list;
  Result(
      {this.pageNumber,
        this.pageSize,
        this.totalRow,
        this.totalPage,
        this.list});
  Result.fromJson(Map<String, dynamic> json) {
    pageNumber = json['page_number'];
    pageSize = json['page_size'];
    totalRow = json['total_row'];
    totalPage = json['total_page'];
    if (json['list'] != null) {
      list = <Listbody>[];
      json['list'].forEach((v) {
        list!.add(new Listbody.fromJson(v));
      });
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page_number'] = this.pageNumber;
    data['page_size'] = this.pageSize;
    data['total_row'] = this.totalRow;
    data['total_page'] = this.totalPage;
    if (this.list != null) {
      data['list'] = this.list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class Listbody {
  int? id;
  String? familyName;
  String? firstName;
  String? lastName;
  String? address;
  String? regNo;
  String? birthDate;
  String? phone;
  int? gender;
  int? reasonNotEmployment;
  String? position;
  int? educationSituation;
  int? bloodType;
  int? employment;
  int? maritalStatus;
  int? isDisability;
  String? numberFamilies;
  int? workingConditions;
  int? orgId;
  String? nationality;
  String? profession;
  String? office;
  int? isAlcohol;
  int? isCigarette;
  int? isMedicine;
  String? isMedicineWrite;
  Listbody(
      {this.id,
        this.familyName,
        this.firstName,
        this.lastName,
        this.address,
        this.regNo,
        this.birthDate,
        this.phone,
        this.gender,
        this.reasonNotEmployment,
        this.position,
        this.educationSituation,
        this.bloodType,
        this.employment,
        this.maritalStatus,
        this.isDisability,
        this.numberFamilies,
        this.workingConditions,
        this.orgId,
        this.nationality,
        this.profession,
        this.office,
        this.isAlcohol,
        this.isCigarette,
        this.isMedicine,
        this.isMedicineWrite});
  Listbody.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    familyName = json['family_name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    address = json['address'];
    regNo = json['reg_no'];
    birthDate = json['birth_date'];
    phone = json['phone'];
    gender = json['gender'];
    reasonNotEmployment = json['reason_not_employment'];
    position = json['position'];
    educationSituation = json['education_situation'];
    bloodType = json['blood_type'];
    employment = json['employment'];
    maritalStatus = json['marital_status'];
    isDisability = json['is_disability'];
    numberFamilies = json['number_families'];
    workingConditions = json['working_conditions'];
    orgId = json['org_id'];
    nationality = json['nationality'];
    profession = json['profession'];
    office = json['office'];
    isAlcohol = json['is_alcohol'];
    isCigarette = json['is_cigarette'];
    isMedicine = json['is_medicine'];
    isMedicineWrite = json['is_medicine_write'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['family_name'] = this.familyName;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['address'] = this.address;
    data['reg_no'] = this.regNo;
    data['birth_date'] = this.birthDate;
    data['phone'] = this.phone;
    data['gender'] = this.gender;
    data['reason_not_employment'] = this.reasonNotEmployment;
    data['position'] = this.position;
    data['education_situation'] = this.educationSituation;
    data['blood_type'] = this.bloodType;
    data['employment'] = this.employment;
    data['marital_status'] = this.maritalStatus;
    data['is_disability'] = this.isDisability;
    data['number_families'] = this.numberFamilies;
    data['working_conditions'] = this.workingConditions;
    data['org_id'] = this.orgId;
    data['nationality'] = this.nationality;
    data['profession'] = this.profession;
    data['office'] = this.office;
    data['is_alcohol'] = this.isAlcohol;
    data['is_cigarette'] = this.isCigarette;
    data['is_medicine'] = this.isMedicine;
    data['is_medicine_write'] = this.isMedicineWrite;
    return data;
  }
}