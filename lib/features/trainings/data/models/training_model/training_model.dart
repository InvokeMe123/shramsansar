class TrainingModel {
  List<Data>? data;
  Links? links;
  Meta? meta;

  TrainingModel({this.data, this.links, this.meta});

  TrainingModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    links = json['links'] != null ? Links.fromJson(json['links']) : null;
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (links != null) {
      data['links'] = links!.toJson();
    }
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? serviceProviderName;
  String? title;
  int? noOfParticipant;
  String? startDate;
  String? startTime;
  String? endDate;
  String? engEndDate;
  String? endTime;
  String? categoryName;
  String? description;
  String? pradeshName;
  String? districtName;
  String? muniName;
  String? ward;
  ServiceProvider? serviceProvider;

  Data(
      {this.id,
      this.serviceProviderName,
      this.title,
      this.noOfParticipant,
      this.startDate,
      this.startTime,
      this.endDate,
      this.engEndDate,
      this.endTime,
      this.categoryName,
      this.description,
      this.pradeshName,
      this.districtName,
      this.muniName,
      this.ward,
      this.serviceProvider});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceProviderName = json['service_provider_name'];
    title = json['title'];
    noOfParticipant = json['no_of_participant'];
    startDate = json['start_date'];
    startTime = json['start_time'];
    endDate = json['end_date'];
    engEndDate = json['eng_end_date'];
    endTime = json['end_time'];
    categoryName = json['category_name'];
    description = json['description'];
    pradeshName = json['pradesh_name'];
    districtName = json['district_name'];
    muniName = json['muni_name'];
    ward = json['ward'];
    serviceProvider = json['serviceProvider'] != null
        ? ServiceProvider.fromJson(json['serviceProvider'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['service_provider_name'] = serviceProviderName;
    data['title'] = title;
    data['no_of_participant'] = noOfParticipant;
    data['start_date'] = startDate;
    data['start_time'] = startTime;
    data['end_date'] = endDate;
    data['eng_end_date'] = engEndDate;
    data['end_time'] = endTime;
    data['category_name'] = categoryName;
    data['description'] = description;
    data['pradesh_name'] = pradeshName;
    data['district_name'] = districtName;
    data['muni_name'] = muniName;
    data['ward'] = ward;
    if (serviceProvider != null) {
      data['serviceProvider'] = serviceProvider!.toJson();
    }
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

class Links {
  String? first;
  String? last;
  String? prev;
  String? next;

  Links({this.first, this.last, this.prev, this.next});

  Links.fromJson(Map<String, dynamic> json) {
    first = json['first'];
    last = json['last'];
    prev = json['prev'];
    next = json['next'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first'] = first;
    data['last'] = last;
    data['prev'] = prev;
    data['next'] = next;
    return data;
  }
}

class Meta {
  int? currentPage;
  int? from;
  int? lastPage;
  List<Links2>? links2;
  String? path;
  int? perPage;
  int? to;
  int? total;

  Meta(
      {this.currentPage,
      this.from,
      this.lastPage,
      this.links2,
      this.path,
      this.perPage,
      this.to,
      this.total});

  Meta.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    from = json['from'];
    lastPage = json['last_page'];
    if (json['links2'] != null) {
      links2 = <Links2>[];
      json['links2'].forEach((v) {
        links2!.add(Links2.fromJson(v));
      });
    }
    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    data['from'] = from;
    data['last_page'] = lastPage;
    if (links2 != null) {
      data['links2'] = links2!.map((v) => v.toJson()).toList();
    }
    data['path'] = path;
    data['per_page'] = perPage;
    data['to'] = to;
    data['total'] = total;
    return data;
  }
}

class Links2 {
  String? url;
  String? label;
  bool? active;

  Links2({this.url, this.label, this.active});

  Links2.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['label'] = label;
    data['active'] = active;
    return data;
  }
}
