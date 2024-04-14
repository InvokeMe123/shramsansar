class AboutMeModel {
  List<AboutYou>? aboutYou;

  AboutMeModel({this.aboutYou});

  AboutMeModel.fromJson(Map<String, dynamic> json) {
    if (json['aboutYou'] != null) {
      aboutYou = <AboutYou>[];
      json['aboutYou'].forEach((v) {
        aboutYou!.add(new AboutYou.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.aboutYou != null) {
      data['aboutYou'] = this.aboutYou!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AboutYou {
  int? id;
  int? jobSeekerId;
  String? aboutMe;

  AboutYou({this.id, this.jobSeekerId, this.aboutMe});

  AboutYou.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobSeekerId = json['job_seeker_id'];
    aboutMe = json['about_me'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['job_seeker_id'] = this.jobSeekerId;
    data['about_me'] = this.aboutMe;
    return data;
  }
}