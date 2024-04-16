// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class EducationReqModel {
  final String level_id;
  final String program;
  final String board;
  final String institute;
  final String graduation_year;
  final String marks_secured;
  EducationReqModel({
    required this.level_id,
    required this.program,
    required this.board,
    required this.institute,
    required this.graduation_year,
    required this.marks_secured,
  });

  EducationReqModel copyWith({
    String? level_id,
    String? program,
    String? board,
    String? institute,
    String? graduation_year,
    String? marks_secured,
  }) {
    return EducationReqModel(
      level_id: level_id ?? this.level_id,
      program: program ?? this.program,
      board: board ?? this.board,
      institute: institute ?? this.institute,
      graduation_year: graduation_year ?? this.graduation_year,
      marks_secured: marks_secured ?? this.marks_secured,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'level_id': level_id,
      'program': program,
      'board': board,
      'institute': institute,
      'graduation_year': graduation_year,
      'marks_secured': marks_secured,
    };
  }

  factory EducationReqModel.fromMap(Map<String, dynamic> map) {
    return EducationReqModel(
      level_id: map['level_id'] as String,
      program: map['program'] as String,
      board: map['board'] as String,
      institute: map['institute'] as String,
      graduation_year: map['graduation_year'] as String,
      marks_secured: map['marks_secured'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory EducationReqModel.fromJson(String source) =>
      EducationReqModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'EducationReqModel(level_id: $level_id, program: $program, board: $board, institute: $institute, graduation_year: $graduation_year, marks_secured: $marks_secured)';
  }

  @override
  bool operator ==(covariant EducationReqModel other) {
    if (identical(this, other)) return true;

    return other.level_id == level_id &&
        other.program == program &&
        other.board == board &&
        other.institute == institute &&
        other.graduation_year == graduation_year &&
        other.marks_secured == marks_secured;
  }

  @override
  int get hashCode {
    return level_id.hashCode ^
        program.hashCode ^
        board.hashCode ^
        institute.hashCode ^
        graduation_year.hashCode ^
        marks_secured.hashCode;
  }
}
