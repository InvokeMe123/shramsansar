// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class JobCategoryModel {
  List<DataModel> data;

  JobCategoryModel({
    required this.data,
  });

  factory JobCategoryModel.fromJson(dynamic source) {
    if (source is String) {
      return JobCategoryModel.fromMap(
          json.decode(source) as Map<String, dynamic>);
    } else if (source is List<dynamic>) {
      return JobCategoryModel.fromList(source);
    } else {
      throw ArgumentError('Invalid source type for JobCategoryModel.fromJson');
    }
  }

  factory JobCategoryModel.fromMap(Map<String, dynamic> map) {
    return JobCategoryModel(
      data: List<DataModel>.from(
        map['data'].map<DataModel>(
            (x) => DataModel.fromMap(x as Map<String, dynamic>)),
      ),
    );
  }

  factory JobCategoryModel.fromList(List<dynamic> list) {
    return JobCategoryModel(
      data: List<DataModel>.from(
        list.map<DataModel>(
            (x) => DataModel.fromMap(x as Map<String, dynamic>)),
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'data': data.map((x) => x.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() => 'JobCategoryModel(data: $data)';

  map(Function(dynamic JobCategoryModel) param0) {}
}

class DataModel {
  int id;
  String name;
  int status;
  DataModel({
    required this.id,
    required this.name,
    required this.status,
  });

  DataModel copyWith({
    int? id,
    String? name,
    int? status,
  }) {
    return DataModel(
      id: id ?? this.id,
      name: name ?? this.name,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'status': status,
    };
  }

  factory DataModel.fromMap(Map<String, dynamic> map) {
    return DataModel(
      id: map['id'] as int,
      name: map['name'] as String,
      status: map['status'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DataModel.fromJson(String source) =>
      DataModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'DataModel(id: $id, name: $name, status: $status)';

  @override
  bool operator ==(covariant DataModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name && other.status == status;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ status.hashCode;
}
