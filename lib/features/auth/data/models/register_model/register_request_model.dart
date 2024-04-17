// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:dio/dio.dart';

class RegisterRequestModel {
  String name;
  String email;
  String password;
  String password_confirmation;
  String gender;
  FormData document;
  int documentType;
  int per_pradesh_id;
  int per_district_id;
  int per_muni_id;
  int per_ward;
  int pradesh_id;
  int district_id;
  int muni_id;
  int ward;
  int mobile;
  int preferredJobCateogryId;
  int casteId;

  RegisterRequestModel({
    required this.name,
    required this.email,
    required this.password,
    required this.password_confirmation,
    required this.gender,
    required this.per_pradesh_id,
    required this.per_district_id,
    required this.per_muni_id,
    required this.per_ward,
    required this.pradesh_id,
    required this.district_id,
    required this.muni_id,
    required this.ward,
    required this.mobile,
    required this.preferredJobCateogryId,
    required this.casteId,
    required this.document,
    required this.documentType,
  });

  RegisterRequestModel copyWith({
    String? name,
    String? email,
    String? password,
    String? password_confirmation,
    String? gender,
    int? per_pradesh_id,
    int? per_district_id,
    int? per_muni_id,
    int? per_ward,
    int? pradesh_id,
    int? district_id,
    int? muni_id,
    int? ward,
    int? mobile,
    int? preferredJobCateogryId,
    int? casteId,
    FormData? document,
    int? documentType,
  }) {
    return RegisterRequestModel(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      password_confirmation:
          password_confirmation ?? this.password_confirmation,
      gender: gender ?? this.gender,
      per_pradesh_id: per_pradesh_id ?? this.per_pradesh_id,
      per_district_id: per_district_id ?? this.per_district_id,
      per_muni_id: per_muni_id ?? this.per_muni_id,
      per_ward: per_ward ?? this.per_ward,
      pradesh_id: pradesh_id ?? this.pradesh_id,
      district_id: district_id ?? this.district_id,
      muni_id: muni_id ?? this.muni_id,
      ward: ward ?? this.ward,
      mobile: mobile ?? this.mobile,
      preferredJobCateogryId:
          preferredJobCateogryId ?? this.preferredJobCateogryId,
      casteId: casteId ?? this.casteId,
      document: document ?? this.document,
      documentType: documentType ?? this.documentType,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'password': password,
      'password_confirmation': password_confirmation,
      'gender': gender,
      'per_pradesh_id': per_pradesh_id,
      'per_district_id': per_district_id,
      'per_muni_id': per_muni_id,
      'per_ward': per_ward,
      'pradesh_id': pradesh_id,
      'district_id': district_id,
      'muni_id': muni_id,
      'ward': ward,
      'mobile': mobile,
      'preference_job_cat[0]': preferredJobCateogryId,
      'ethnicity_type': casteId,
      'document_type_file': document,
      'document_type': documentType,
    };
  }

  factory RegisterRequestModel.fromMap(Map<String, dynamic> map) {
    return RegisterRequestModel(
      name: map['name'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      password_confirmation: map['password_confirmation'] as String,
      gender: map['gender'] as String,
      per_pradesh_id: map['per_pradesh_id'] as int,
      per_district_id: map['per_district_id'] as int,
      per_muni_id: map['per_muni_id'] as int,
      per_ward: map['per_ward'] as int,
      pradesh_id: map['pradesh_id'] as int,
      district_id: map['district_id'] as int,
      muni_id: map['muni_id'] as int,
      ward: map['ward'] as int,
      mobile: map['mobile'] as int,
      preferredJobCateogryId: map['preference_job_cat[0]'] as int,
      casteId: map["caste"] as int,
      document: map["document_type_file"] as FormData,
      documentType: map["document_type"] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory RegisterRequestModel.fromJson(String source) =>
      RegisterRequestModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RegisterRequestModel(name: $name, email: $email, password: $password, password_confirmation: $password_confirmation, gender: $gender, per_pradesh_id: $per_pradesh_id, per_district_id: $per_district_id, per_muni_id: $per_muni_id, per_ward: $per_ward, pradesh_id: $pradesh_id, district_id: $district_id, muni_id: $muni_id, ward: $ward, mobile: $mobile)';
  }

  @override
  bool operator ==(covariant RegisterRequestModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.email == email &&
        other.password == password &&
        other.password_confirmation == password_confirmation &&
        other.gender == gender &&
        other.per_pradesh_id == per_pradesh_id &&
        other.per_district_id == per_district_id &&
        other.per_muni_id == per_muni_id &&
        other.per_ward == per_ward &&
        other.pradesh_id == pradesh_id &&
        other.district_id == district_id &&
        other.muni_id == muni_id &&
        other.ward == ward &&
        other.mobile == mobile;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        email.hashCode ^
        password.hashCode ^
        password_confirmation.hashCode ^
        gender.hashCode ^
        per_pradesh_id.hashCode ^
        per_district_id.hashCode ^
        per_muni_id.hashCode ^
        per_ward.hashCode ^
        pradesh_id.hashCode ^
        district_id.hashCode ^
        muni_id.hashCode ^
        ward.hashCode ^
        mobile.hashCode;
  }
}
