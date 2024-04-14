// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class EducationResModel {
  final String message; 
  EducationResModel({
    required this.message,
  });
  

  EducationResModel copyWith({
    String? message,
  }) {
    return EducationResModel(
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
    };
  }

  factory EducationResModel.fromMap(Map<String, dynamic> map) {
    return EducationResModel(
      message: map['message'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory EducationResModel.fromJson(String source) => EducationResModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'EducationResModel(message: $message)';

  @override
  bool operator ==(covariant EducationResModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
