class TrainingCentersModel {
  List<Data>? data;
  Links? links;
  Meta? meta;

  TrainingCentersModel({this.data, this.links, this.meta});

  TrainingCentersModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    links = json['links'] != null ? new Links.fromJson(json['links']) : null;
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.links != null) {
      data['links'] = this.links!.toJson();
    }
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    return data;
  }
}

class Data {
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

  Data(
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

  Data.fromJson(Map<String, dynamic> json) {
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

class Links {
  String? first;
  String? last;
  Null? prev;
  String? next;

  Links({this.first, this.last, this.prev, this.next});

  Links.fromJson(Map<String, dynamic> json) {
    first = json['first'];
    last = json['last'];
    prev = json['prev'];
    next = json['next'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first'] = this.first;
    data['last'] = this.last;
    data['prev'] = this.prev;
    data['next'] = this.next;
    return data;
  }
}

class Meta {
  int? currentPage;
  int? from;
  int? lastPage;
  List<Links>? links;
  String? path;
  int? perPage;
  int? to;
  int? total;

  Meta(
      {this.currentPage,
      this.from,
      this.lastPage,
      this.links,
      this.path,
      this.perPage,
      this.to,
      this.total});

  Meta.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    from = json['from'];
    lastPage = json['last_page'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(new Links.fromJson(v));
      });
    }
    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    if (this.links != null) {
      data['links'] = this.links!.map((v) => v.toJson()).toList();
    }
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}
