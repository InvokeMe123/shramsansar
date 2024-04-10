// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AboutMeUpdateReqModel {
  final String about_me;
  AboutMeUpdateReqModel({
    required this.about_me,
  });

  AboutMeUpdateReqModel copyWith({
    String? about_me,
  }) {
    return AboutMeUpdateReqModel(
      about_me: about_me ?? this.about_me,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'about_me': about_me,
    };
  }

  factory AboutMeUpdateReqModel.fromMap(Map<String, dynamic> map) {
    return AboutMeUpdateReqModel(
      about_me: map['about_me'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AboutMeUpdateReqModel.fromJson(String source) => AboutMeUpdateReqModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'AboutMeUpdateReqModel(about_me: $about_me)';

  @override
  bool operator ==(covariant AboutMeUpdateReqModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.about_me == about_me;
  }

  @override
  int get hashCode => about_me.hashCode;
}
