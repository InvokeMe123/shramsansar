class LatestJobModel {
  List<Data>? data;
  bool? success;

  LatestJobModel({this.data, this.success});

  LatestJobModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['success'] = this.success;
    return data;
  }
}

class Data {
  int? id;
  String? serviceProviderName;
  String? title;
  String? positionType;
  int? categoryId;
  String? categoryName;
  String? openings;
  int? pradeshId;
  String? pradeshName;
  int? districtId;
  String? districtName;
  int? muniId;
  String? muniName;
  int? ward;
  String? address;
  String? deadline;
  String? engDeadline;
  String? description;
  String? specification;
  String? salaryMin;
  String? salaryMax;
  String? requiredExperience;
  String? requiredEducation;
  int? discloseOrgAddress;
  Organization? organization;
  ServiceProvider? serviceProvider;

  Data(
      {this.id,
      this.serviceProviderName,
      this.title,
      this.positionType,
      this.categoryId,
      this.categoryName,
      this.openings,
      this.pradeshId,
      this.pradeshName,
      this.districtId,
      this.districtName,
      this.muniId,
      this.muniName,
      this.ward,
      this.address,
      this.deadline,
      this.engDeadline,
      this.description,
      this.specification,
      this.salaryMin,
      this.salaryMax,
      this.requiredExperience,
      this.requiredEducation,
      this.discloseOrgAddress,
      this.organization,
      this.serviceProvider});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceProviderName = json['service_provider_name'];
    title = json['title'];
    positionType = json['position_type'];
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    openings = json['openings'];
    pradeshId = json['pradesh_id'];
    pradeshName = json['pradesh_name'];
    districtId = json['district_id'];
    districtName = json['district_name'];
    muniId = json['muni_id'];
    muniName = json['muni_name'];
    ward = json['ward'];
    address = json['address'];
    deadline = json['deadline'];
    engDeadline = json['eng_deadline'];
    description = json['description'];
    specification = json['specification'];
    salaryMin = json['salary_min'];
    salaryMax = json['salary_max'];
    requiredExperience = json['required_experience'];
    requiredEducation = json['required_education'];
    discloseOrgAddress = json['disclose_org_address'];
    organization = json['organization'] != null
        ? new Organization.fromJson(json['organization'])
        : null;
    serviceProvider = json['serviceProvider'] != null
        ? new ServiceProvider.fromJson(json['serviceProvider'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['service_provider_name'] = this.serviceProviderName;
    data['title'] = this.title;
    data['position_type'] = this.positionType;
    data['category_id'] = this.categoryId;
    data['category_name'] = this.categoryName;
    data['openings'] = this.openings;
    data['pradesh_id'] = this.pradeshId;
    data['pradesh_name'] = this.pradeshName;
    data['district_id'] = this.districtId;
    data['district_name'] = this.districtName;
    data['muni_id'] = this.muniId;
    data['muni_name'] = this.muniName;
    data['ward'] = this.ward;
    data['address'] = this.address;
    data['deadline'] = this.deadline;
    data['eng_deadline'] = this.engDeadline;
    data['description'] = this.description;
    data['specification'] = this.specification;
    data['salary_min'] = this.salaryMin;
    data['salary_max'] = this.salaryMax;
    data['required_experience'] = this.requiredExperience;
    data['required_education'] = this.requiredEducation;
    data['disclose_org_address'] = this.discloseOrgAddress;
    if (this.organization != null) {
      data['organization'] = this.organization!.toJson();
    }
    if (this.serviceProvider != null) {
      data['serviceProvider'] = this.serviceProvider!.toJson();
    }
    return data;
  }
}

class Organization {
  int? id;
  String? name;
  String? pradeshName;
  String? districtName;
  String? muniName;
  int? ward;
  String? address;
  String? email;
  String? contactNumber;

  Organization(
      {this.id,
      this.name,
      this.pradeshName,
      this.districtName,
      this.muniName,
      this.ward,
      this.address,
      this.email,
      this.contactNumber});

  Organization.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    pradeshName = json['pradesh_name'];
    districtName = json['district_name'];
    muniName = json['muni_name'];
    ward = json['ward'];
    address = json['address'];
    email = json['email'];
    contactNumber = json['contact_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['pradesh_name'] = this.pradeshName;
    data['district_name'] = this.districtName;
    data['muni_name'] = this.muniName;
    data['ward'] = this.ward;
    data['address'] = this.address;
    data['email'] = this.email;
    data['contact_number'] = this.contactNumber;
    return data;
  }
}

class ServiceProvider {
  int? id;
  String? name;
  String? pradeshName;
  String? districtName;
  String? muniName;
  String? ward;
  int? type;
  String? typeName;
  String? phone;
  String? mobile;
  String? email;
  String? website;
  String? description;
  String? logo;

  ServiceProvider(
      {this.id,
      this.name,
      this.pradeshName,
      this.districtName,
      this.muniName,
      this.ward,
      this.type,
      this.typeName,
      this.phone,
      this.mobile,
      this.email,
      this.website,
      this.description,
      this.logo});

  ServiceProvider.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    pradeshName = json['pradesh_name'];
    districtName = json['district_name'];
    muniName = json['muni_name'];
    ward = json['ward'];
    type = json['type'];
    typeName = json['type_name'];
    phone = json['phone'];
    mobile = json['mobile'];
    email = json['email'];
    website = json['website'];
    description = json['description'];
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['pradesh_name'] = this.pradeshName;
    data['district_name'] = this.districtName;
    data['muni_name'] = this.muniName;
    data['ward'] = this.ward;
    data['type'] = this.type;
    data['type_name'] = this.typeName;
    data['phone'] = this.phone;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['website'] = this.website;
    data['description'] = this.description;
    data['logo'] = this.logo;
    return data;
  }
}