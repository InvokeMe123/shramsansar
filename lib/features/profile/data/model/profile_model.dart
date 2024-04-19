

class MyProfileModel {
  int? id;
  String? name;
  String? email;
  int? perPradeshId;
  String? perPradeshName;
  int? perDistrictId;
  String? perDistrictName;
  int? perMuniId;
  String? perMuniName;
  String? perWard;
  int? pradeshId;
  String? tempPradeshName;
  int? districtId;
  String? tempDistrictName;
  int? muniId;
  String? tempMuniName;
  String? ward;
  String? dob;
  String? gender;
  String? mobile;
  String? phone;
  String? otherSkills;
  String? citizenshipNo;
  String? expectedSalary;
  String? ethnicityType;
  String? ethnicityName;
  int? differentlyAble;
  int? migrantWorker;
  int? minorityGroup;
  String? file;
  List<JobseekerPreferenceCategory>? jobseekerPreferenceCategory;
  List<Educations>? educations;
  List<Experiences>? experiences;
  List<Trainings>? trainings;
  List<Languages>? languages;
  List<Locations>? locations;
  List<SocialAccounts>? socialAccounts;
  Specialization? specialization;
  AboutYourself? aboutYourself;
  List<Skills>? skills;

  MyProfileModel(
      {this.id,
      this.name,
      this.email,
      this.perPradeshId,
      this.perPradeshName,
      this.perDistrictId,
      this.perDistrictName,
      this.perMuniId,
      this.perMuniName,
      this.perWard,
      this.pradeshId,
      this.tempPradeshName,
      this.districtId,
      this.tempDistrictName,
      this.muniId,
      this.tempMuniName,
      this.ward,
      this.dob,
      this.gender,
      this.mobile,
      this.phone,
      this.otherSkills,
      this.citizenshipNo,
      this.expectedSalary,
      this.ethnicityType,
      this.ethnicityName,
      this.differentlyAble,
      this.migrantWorker,
      this.minorityGroup,
      this.file,
      this.jobseekerPreferenceCategory,
      this.educations,
      this.experiences,
      this.trainings,
      this.languages,
      this.locations,
      this.socialAccounts,
      this.specialization,
      this.aboutYourself,
      this.skills});

  MyProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    perPradeshId = json['per_pradesh_id'];
    perPradeshName = json['per_pradesh_name'];
    perDistrictId = json['per_district_id'];
    perDistrictName = json['per_district_name'];
    perMuniId = json['per_muni_id'];
    perMuniName = json['per_muni_name'];
    perWard = json['per_ward'];
    pradeshId = json['pradesh_id'];
    tempPradeshName = json['temp_pradesh_name'];
    districtId = json['district_id'];
    tempDistrictName = json['temp_district_name'];
    muniId = json['muni_id'];
    tempMuniName = json['temp_muni_name'];
    ward = json['ward'];
    dob = json['dob'];
    gender = json['gender'];
    mobile = json['mobile'];
    phone = json['phone'];
    otherSkills = json['other_skills'];
    citizenshipNo = json['citizenship_no'];
    expectedSalary = json['expected_salary'];
    ethnicityType = json['ethnicity_type'];
    ethnicityName = json['ethnicity_name'];
    differentlyAble = json['differently_able'];
    migrantWorker = json['migrant_worker'];
    minorityGroup = json['minority_group'];
    file = json['file'];
    if (json['jobseeker_preference_category'] != null) {
      jobseekerPreferenceCategory = <JobseekerPreferenceCategory>[];
      json['jobseeker_preference_category'].forEach((v) {
        jobseekerPreferenceCategory!
            .add(JobseekerPreferenceCategory.fromJson(v));
      });
    }
    if (json['educations'] != null) {
      educations = <Educations>[];
      json['educations'].forEach((v) {
        educations!.add(Educations.fromJson(v));
      });
    }
    if (json['experiences'] != null) {
      experiences = <Experiences>[];
      json['experiences'].forEach((v) {
        experiences!.add(Experiences.fromJson(v));
      });
    }
    if (json['trainings'] != null) {
      trainings = <Trainings>[];
      json['trainings'].forEach((v) {
        trainings!.add(Trainings.fromJson(v));
      });
    }
    if (json['languages'] != null) {
      languages = <Languages>[];
      json['languages'].forEach((v) {
        languages!.add(Languages.fromJson(v));
      });
    }
    if (json['locations'] != null) {
      locations = <Locations>[];
      json['locations'].forEach((v) {
        locations!.add(Locations.fromJson(v));
      });
    }
    if (json['socialAccounts'] != null) {
      socialAccounts = <SocialAccounts>[];
      json['socialAccounts'].forEach((v) {
        socialAccounts!.add(SocialAccounts.fromJson(v));
      });
    }
    specialization = json['specialization'] != null
        ? Specialization.fromJson(json['specialization'])
        : null;
    aboutYourself = json['aboutYourself'] != null
        ? AboutYourself.fromJson(json['aboutYourself'])
        : null;
    if (json['skills'] != null) {
      skills = <Skills>[];
      json['skills'].forEach((v) {
        skills!.add(Skills.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> MyProfileModel = <String, dynamic>{};
    MyProfileModel['id'] = id;
    MyProfileModel['name'] = name;
    MyProfileModel['email'] = email;
    MyProfileModel['per_pradesh_id'] = perPradeshId;
    MyProfileModel['per_pradesh_name'] = perPradeshName;
    MyProfileModel['per_district_id'] = perDistrictId;
    MyProfileModel['per_district_name'] = perDistrictName;
    MyProfileModel['per_muni_id'] = perMuniId;
    MyProfileModel['per_muni_name'] = perMuniName;
    MyProfileModel['per_ward'] = perWard;
    MyProfileModel['pradesh_id'] = pradeshId;
    MyProfileModel['temp_pradesh_name'] = tempPradeshName;
    MyProfileModel['district_id'] = districtId;
    MyProfileModel['temp_district_name'] = tempDistrictName;
    MyProfileModel['muni_id'] = muniId;
    MyProfileModel['temp_muni_name'] = tempMuniName;
    MyProfileModel['ward'] = ward;
    MyProfileModel['dob'] = dob;
    MyProfileModel['gender'] = gender;
    MyProfileModel['mobile'] = mobile;
    MyProfileModel['phone'] = phone;
    MyProfileModel['other_skills'] = otherSkills;
    MyProfileModel['citizenship_no'] = citizenshipNo;
    MyProfileModel['expected_salary'] = expectedSalary;
    MyProfileModel['ethnicity_type'] = ethnicityType;
    MyProfileModel['ethnicity_name'] = ethnicityName;
    MyProfileModel['differently_able'] = differentlyAble;
    MyProfileModel['migrant_worker'] = migrantWorker;
    MyProfileModel['minority_group'] = minorityGroup;
    MyProfileModel['file'] = file;
    if (jobseekerPreferenceCategory != null) {
      MyProfileModel['jobseeker_preference_category'] =
          jobseekerPreferenceCategory!.map((v) => v.toJson()).toList();
    }
    if (educations != null) {
      MyProfileModel['educations'] =
          educations!.map((v) => v.toJson()).toList();
    }
    if (experiences != null) {
      MyProfileModel['experiences'] =
          experiences!.map((v) => v.toJson()).toList();
    }
    if (trainings != null) {
      MyProfileModel['trainings'] =
          trainings!.map((v) => v.toJson()).toList();
    }
    if (languages != null) {
      MyProfileModel['languages'] =
          languages!.map((v) => v.toJson()).toList();
    }
    if (locations != null) {
      MyProfileModel['locations'] = locations!.map((v) => v.toJson()).toList();
    }
    if (socialAccounts != null) {
      MyProfileModel['socialAccounts'] =
          socialAccounts!.map((v) => v.toJson()).toList();
    }
    if (specialization != null) {
      MyProfileModel['specialization'] = specialization!.toJson();
    }
    if (aboutYourself != null) {
      MyProfileModel['aboutYourself'] = aboutYourself!.toJson();
    }
    if (skills != null) {
      MyProfileModel['skills'] = skills!.map((v) => v.toJson()).toList();
    }
    return MyProfileModel;
  }

  MyProfileModel copyWith({
    int? id,
    String? name,
    String? email,
    int? perPradeshId,
    String? perPradeshName,
    int? perDistrictId,
    String? perDistrictName,
    int? perMuniId,
    String? perMuniName,
    String? perWard,
    int? pradeshId,
    String? tempPradeshName,
    int? districtId,
    String? tempDistrictName,
    int? muniId,
    String? tempMuniName,
    String? ward,
    String? dob,
    String? gender,
    String? mobile,
    String? phone,
    String? otherSkills,
    String? citizenshipNo,
    String? expectedSalary,
    String? ethnicityType,
    String? ethnicityName,
    int? differentlyAble,
    int? migrantWorker,
    int? minorityGroup,
    String? file,
    List<JobseekerPreferenceCategory>? jobseekerPreferenceCategory,
    List<Educations>? educations,
    List<Experiences>? experiences,
    List<Trainings>? trainings,
    List<Languages>? languages,
    List<Locations>? locations,
    List<SocialAccounts>? socialAccounts,
    Specialization? specialization,
    AboutYourself? aboutYourself,
    List<Skills>? skills,
  }) {
    return MyProfileModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      perPradeshId: perPradeshId ?? this.perPradeshId,
      perPradeshName: perPradeshName ?? this.perPradeshName,
      perDistrictId: perDistrictId ?? this.perDistrictId,
      perDistrictName: perDistrictName ?? this.perDistrictName,
      perMuniId: perMuniId ?? this.perMuniId,
      perMuniName: perMuniName ?? this.perMuniName,
      perWard: perWard ?? this.perWard,
      pradeshId: pradeshId ?? this.pradeshId,
      tempPradeshName: tempPradeshName ?? this.tempPradeshName,
      districtId: districtId ?? this.districtId,
      tempDistrictName: tempDistrictName ?? this.tempDistrictName,
      muniId: muniId ?? this.muniId,
      tempMuniName: tempMuniName ?? this.tempMuniName,
      ward: ward ?? this.ward,
      dob: dob ?? this.dob,
      gender: gender ?? this.gender,
      mobile: mobile ?? this.mobile,
      phone: phone ?? this.phone,
      otherSkills: otherSkills ?? this.otherSkills,
      citizenshipNo: citizenshipNo ?? this.citizenshipNo,
      expectedSalary: expectedSalary ?? this.expectedSalary,
      ethnicityType: ethnicityType ?? this.ethnicityType,
      ethnicityName: ethnicityName ?? this.ethnicityName,
      differentlyAble: differentlyAble ?? this.differentlyAble,
      migrantWorker: migrantWorker ?? this.migrantWorker,
      minorityGroup: minorityGroup ?? this.minorityGroup,
      file: file ?? this.file,
      jobseekerPreferenceCategory:
          jobseekerPreferenceCategory ?? this.jobseekerPreferenceCategory,
      educations: educations ?? this.educations,
      experiences: experiences ?? this.experiences,
      trainings: trainings ?? this.trainings,
      languages: languages ?? this.languages,
      locations: locations ?? this.locations,
      socialAccounts: socialAccounts ?? this.socialAccounts,
      specialization: specialization ?? this.specialization,
      aboutYourself: aboutYourself ?? this.aboutYourself,
      skills: skills ?? this.skills,
    );
  }
}

class JobseekerPreferenceCategory {
  int? id;
  String? categoryId;
  String? categoryName;

  JobseekerPreferenceCategory({this.id, this.categoryId, this.categoryName});

  JobseekerPreferenceCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    categoryName = json['category_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> MyProfileModel = <String, dynamic>{};
    MyProfileModel['id'] = id;
    MyProfileModel['category_id'] = categoryId;
    MyProfileModel['category_name'] = categoryName;
    return MyProfileModel;
  }
}

class Educations {
  int? id;
  int? levelId;
  String? levelName;
  String? program;
  String? board;
  String? institute;
  String? graduationYear;
  String? marksSecured;

  Levels? levels;

  Educations(
      {this.id,
      this.levelId,
      this.levelName,
      this.program,
      this.board,
      this.institute,
      this.graduationYear,
      this.marksSecured,
      this.levels});

  // CopyWith method implementation
  Educations copyWith({
    int? id,
    int? levelId,
    String? levelName,
    String? program,
    String? board,
    String? institute,
    String? graduationYear,
    String? marksSecured,
    Levels? levels,
  }) {
    return Educations(
      id: id ?? this.id,
      levelId: levelId ?? this.levelId,
      levelName: levelName ?? this.levelName,
      program: program ?? this.program,
      board: board ?? this.board,
      institute: institute ?? this.institute,
      graduationYear: graduationYear ?? this.graduationYear,
      marksSecured: marksSecured ?? this.marksSecured,
      levels: levels ?? this.levels,
    );
  }

  Educations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    levelId = int.tryParse(json['level_id'].toString());
    levelName = json['level_name'];
    program = json['program'];
    board = json['board'];
    institute = json['institute'];
    graduationYear = json['graduation_year'];
    marksSecured = json['marks_secured'];
    levels =
        json['levels'] != null ? Levels.fromJson(json['levels']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> MyProfileModel = <String, dynamic>{};
    MyProfileModel['id'] = id;
    MyProfileModel['level_id'] = levelId;
    MyProfileModel['level_name'] = levelName;
    MyProfileModel['program'] = program;
    MyProfileModel['board'] = board;
    MyProfileModel['institute'] = institute;
    MyProfileModel['graduation_year'] = graduationYear;
    MyProfileModel['marks_secured'] = marksSecured;
    if (levels != null) {
      MyProfileModel['levels'] = levels!.toJson();
    }
    return MyProfileModel;
  }
}

class Levels {
  int? id;
  String? name;

  Levels({this.id, this.name});

  Levels.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> MyProfileModel = <String, dynamic>{};
    MyProfileModel['id'] = id;
    MyProfileModel['name'] = name;
    return MyProfileModel;
  }
}

class Experiences {
  int? id;
  String? organization;
  String? location;
  String? title;
  int? isCurrentlyWorking;
  String? startDate;
  String? endDate;
  String? referenceName;
  String? referenceContact;
  String? file;

  Experiences(
      {this.id,
      this.organization,
      this.location,
      this.title,
      this.isCurrentlyWorking,
      this.startDate,
      this.endDate,
      this.referenceName,
      this.referenceContact,
      this.file});

  Experiences.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    organization = json['organization'];
    location = json['location'];
    title = json['title'];
    isCurrentlyWorking = json['is_currently_working'];
    startDate = json['start_date'];
    endDate = json['end_date'] ?? '';
    referenceName = json['reference_name'];
    referenceContact = json['reference_contact'];
    file = json['file'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> MyProfileModel = <String, dynamic>{};
    MyProfileModel['id'] = id;
    MyProfileModel['organization'] = organization;
    MyProfileModel['location'] = location;
    MyProfileModel['title'] = title;
    MyProfileModel['is_currently_working'] = isCurrentlyWorking;
    MyProfileModel['start_date'] = startDate;
    MyProfileModel['end_date'] = endDate;
    MyProfileModel['reference_name'] = referenceName;
    MyProfileModel['reference_contact'] = referenceContact;
    MyProfileModel['file'] = file;
    return MyProfileModel;
  }
}

class Trainings {
  int? id;
  String? title;
  String? provider;
  String? duration;
  String? year;
  String? details;
  Null file;

  Trainings(
      {this.id,
      this.title,
      this.provider,
      this.duration,
      this.year,
      this.details,
      this.file});

  Trainings.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    provider = json['provider'];
    duration = json['duration'];
    year = json['year'];
    details = json['details'];
    file = json['file'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> MyProfileModel = <String, dynamic>{};
    MyProfileModel['id'] = id;
    MyProfileModel['title'] = title;
    MyProfileModel['provider'] = provider;
    MyProfileModel['duration'] = duration;
    MyProfileModel['year'] = year;
    MyProfileModel['details'] = details;
    MyProfileModel['file'] = file;
    return MyProfileModel;
  }
}

class Languages {
  int? id;
  String? languageName;
  String? languageRatingSpeaking;
  String? languageRatingReading;
  String? languageRatingWriting;
  String? languageRatingListening;

  Languages(
      {this.id,
      this.languageName,
      this.languageRatingSpeaking,
      this.languageRatingReading,
      this.languageRatingWriting,
      this.languageRatingListening});

  Languages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    languageName = json['language_name'];
    languageRatingSpeaking = json['language_rating_speaking'];
    languageRatingReading = json['language_rating_reading'];
    languageRatingWriting = json['language_rating_writing'];
    languageRatingListening = json['language_rating_listening'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> MyProfileModel = <String, dynamic>{};
    MyProfileModel['id'] = id;
    MyProfileModel['language_name'] = languageName;
    MyProfileModel['language_rating_speaking'] = languageRatingSpeaking;
    MyProfileModel['language_rating_reading'] = languageRatingReading;
    MyProfileModel['language_rating_writing'] = languageRatingWriting;
    MyProfileModel['language_rating_listening'] = languageRatingListening;
    return MyProfileModel;
  }
}

class Locations {
  int? id;
  String? location;
  int? perPradeshId;
  String? pradeshName;
  int? perDistrictId;
  String? districtName;
  int? perMuniId;
  String? muniName;

  Locations(
      {this.id,
      this.location,
      this.perPradeshId,
      this.pradeshName,
      this.perDistrictId,
      this.districtName,
      this.perMuniId,
      this.muniName});

  Locations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    location = json['location'];
    perPradeshId = json['per_pradesh_id'];
    pradeshName = json['pradesh_name'];
    perDistrictId = json['per_district_id'];
    districtName = json['district_name'];
    perMuniId = json['per_muni_id'];
    muniName = json['muni_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> MyProfileModel = <String, dynamic>{};
    MyProfileModel['id'] = id;
    MyProfileModel['location'] = location;
    MyProfileModel['per_pradesh_id'] = perPradeshId;
    MyProfileModel['pradesh_name'] = pradeshName;
    MyProfileModel['per_district_id'] = perDistrictId;
    MyProfileModel['district_name'] = districtName;
    MyProfileModel['per_muni_id'] = perMuniId;
    MyProfileModel['muni_name'] = muniName;
    return MyProfileModel;
  }
}

class SocialAccounts {
  int? id;
  String? name;
  String? url;

  SocialAccounts({this.id, this.name, this.url});

  SocialAccounts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> MyProfileModel = <String, dynamic>{};
    MyProfileModel['id'] = id;
    MyProfileModel['name'] = name;
    MyProfileModel['url'] = url;
    return MyProfileModel;
  }
}

class Specialization {
  int? id;
  String? specialization;

  Specialization({this.id, this.specialization});

  Specialization.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    specialization = json['specialization'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> MyProfileModel = <String, dynamic>{};
    MyProfileModel['id'] = id;
    MyProfileModel['specialization'] = specialization;
    return MyProfileModel;
  }
}

class AboutYourself {
  int? id;
  String? description;

  AboutYourself({this.id, this.description});

  AboutYourself.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> MyProfileModel = <String, dynamic>{};
    MyProfileModel['id'] = id;
    MyProfileModel['description'] = description;
    return MyProfileModel;
  }

  // copy with
  AboutYourself copyWith({
    int? id,
    String? description,
  }) {
    return AboutYourself(
      id: id ?? this.id,
      description: description ?? this.description,
    );
  }
}

class Skills {
  int? id;
  int? skillId;
  String? skillName;

  Skills({this.id, this.skillId, this.skillName});

  Skills.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    skillId = json['skill_id'];
    skillName = json['skill_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> MyProfileModel = <String, dynamic>{};
    MyProfileModel['id'] = id;
    MyProfileModel['skill_id'] = skillId;
    MyProfileModel['skill_name'] = skillName;
    return MyProfileModel;
  }
}
