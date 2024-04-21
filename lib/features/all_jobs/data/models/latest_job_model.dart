class LatestJobModel {
  List<Data>? data;
  bool? success;

  LatestJobModel({this.data, this.success});

  LatestJobModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['success'] = success;
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
        ? Organization.fromJson(json['organization'])
        : null;
    serviceProvider = json['serviceProvider'] != null
        ? ServiceProvider.fromJson(json['serviceProvider'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['service_provider_name'] = serviceProviderName;
    data['title'] = title;
    data['position_type'] = positionType;
    data['category_id'] = categoryId;
    data['category_name'] = categoryName;
    data['openings'] = openings;
    data['pradesh_id'] = pradeshId;
    data['pradesh_name'] = pradeshName;
    data['district_id'] = districtId;
    data['district_name'] = districtName;
    data['muni_id'] = muniId;
    data['muni_name'] = muniName;
    data['ward'] = ward;
    data['address'] = address;
    data['deadline'] = deadline;
    data['eng_deadline'] = engDeadline;
    data['description'] = description;
    data['specification'] = specification;
    data['salary_min'] = salaryMin;
    data['salary_max'] = salaryMax;
    data['required_experience'] = requiredExperience;
    data['required_education'] = requiredEducation;
    data['disclose_org_address'] = discloseOrgAddress;
    if (organization != null) {
      data['organization'] = organization!.toJson();
    }
    if (serviceProvider != null) {
      data['serviceProvider'] = serviceProvider!.toJson();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['pradesh_name'] = pradeshName;
    data['district_name'] = districtName;
    data['muni_name'] = muniName;
    data['ward'] = ward;
    data['address'] = address;
    data['email'] = email;
    data['contact_number'] = contactNumber;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['pradesh_name'] = pradeshName;
    data['district_name'] = districtName;
    data['muni_name'] = muniName;
    data['ward'] = ward;
    data['type'] = type;
    data['type_name'] = typeName;
    data['phone'] = phone;
    data['mobile'] = mobile;
    data['email'] = email;
    data['website'] = website;
    data['description'] = description;
    data['logo'] = logo;
    return data;
  }
}