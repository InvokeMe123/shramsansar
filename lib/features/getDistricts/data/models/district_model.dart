// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';


class DistrictModel {
  List<DataModel> data;

  DistrictModel({
    required this.data,
  });

  factory DistrictModel.fromJson(dynamic source) {
    if (source is String) {
      return DistrictModel.fromMap(json.decode(source) as Map<String, dynamic>);
    } else if (source is List<dynamic>) {
      return DistrictModel.fromList(source);
    } else {
      throw ArgumentError('Invalid source type for DistrictModel.fromJson');
    }
  }

  factory DistrictModel.fromMap(Map<String, dynamic> map) {
    return DistrictModel(
      data: List<DataModel>.from(
        map['data'].map<DataModel>(
            (x) => DataModel.fromMap(x as Map<String, dynamic>)),
      ),
    );
  }

  factory DistrictModel.fromList(List<dynamic> list) {
    return DistrictModel(
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
  String toString() => 'DistrictModel(data: $data)';

  map(Function(dynamic DistrictModel) param0) {}
}

class DataModel {
  int id;
  String pradesh_id;
  String pradesh_name;
  String name;
  String code;
  DataModel({
    required this.id,
    required this.pradesh_id,
    required this.pradesh_name,
    required this.name,
    required this.code,
  });

  DataModel copyWith({
    int? id,
    String? pradesh_id,
    String? pradesh_name,
    String? name,
    String? code,
  }) {
    return DataModel(
      id: id ?? this.id,
      pradesh_id: pradesh_id ?? this.pradesh_id,
      pradesh_name: pradesh_name ?? this.pradesh_name,
      name: name ?? this.name,
      code: code ?? this.code,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'pradesh_id': pradesh_id,
      'pradesh_name': pradesh_name,
      'name': name,
      'code': code,
    };
  }

  factory DataModel.fromMap(Map<String, dynamic> map) {
    return DataModel(
      id: map['id'] as int,
      pradesh_id: map['pradesh_id'] as String,
      pradesh_name: map['pradesh_name'] as String,
      name: map['name'] as String,
      code: map['code'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory DataModel.fromJson(String source) =>
      DataModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DataModel(id: $id, pradesh_id: $pradesh_id, pradesh_name: $pradesh_name, name: $name, code: $code)';
  }

  @override
  bool operator ==(covariant DataModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.pradesh_id == pradesh_id &&
        other.pradesh_name == pradesh_name &&
        other.name == name &&
        other.code == code;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        pradesh_id.hashCode ^
        pradesh_name.hashCode ^
        name.hashCode ^
        code.hashCode;
  }
}
