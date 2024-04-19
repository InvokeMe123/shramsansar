// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:dio/dio.dart';

class ExperienceModel {
  String reference_name;
  String reference_contact;
  String end_date;
  String location;
  String is_currently_working;
  FormData file;
  ExperienceModel({
    required this.reference_name,
    required this.reference_contact,
    required this.end_date,
    required this.location,
    required this.is_currently_working,
    required this.file,
  });

  ExperienceModel copyWith({
    String? reference_name,
    String? reference_contact,
    String? end_date,
    String? location,
    String? is_currently_working,
    FormData? file,
  }) {
    return ExperienceModel(
      reference_name: reference_name ?? this.reference_name,
      reference_contact: reference_contact ?? this.reference_contact,
      end_date: end_date ?? this.end_date,
      location: location ?? this.location,
      is_currently_working: is_currently_working ?? this.is_currently_working,
      file: file ?? this.file,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'reference_name': reference_name,
      'reference_contact': reference_contact,
      'end_date': end_date,
      'location': location,
      'is_currently_working': is_currently_working,
    };
  }

  factory ExperienceModel.fromMap(Map<String, dynamic> map) {
    return ExperienceModel(
      reference_name: map['reference_name'] as String,
      reference_contact: map['reference_contact'] as String,
      end_date: map['end_date'] as String,
      location: map['location'] as String,
      is_currently_working: map['is_currently_working'] as String,
      file: FormData.fromMap(map['file'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory ExperienceModel.fromJson(String source) =>
      ExperienceModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ExperienceModel(reference_name: $reference_name, reference_contact: $reference_contact, end_date: $end_date, location: $location, is_currently_working: $is_currently_working, file: $file)';
  }

  @override
  bool operator ==(covariant ExperienceModel other) {
    if (identical(this, other)) return true;

    return other.reference_name == reference_name &&
        other.reference_contact == reference_contact &&
        other.end_date == end_date &&
        other.location == location &&
        other.is_currently_working == is_currently_working &&
        other.file == file;
  }

  @override
  int get hashCode {
    return reference_name.hashCode ^
        reference_contact.hashCode ^
        end_date.hashCode ^
        location.hashCode ^
        is_currently_working.hashCode ^
        file.hashCode;
  }
}
