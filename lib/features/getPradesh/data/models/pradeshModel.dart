// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';


class PradeshModel {
  List<DataModel> data;

  PradeshModel({
    required this.data,
  });

  factory PradeshModel.fromJson(dynamic source) {
    if (source is String) {
      return PradeshModel.fromMap(json.decode(source) as Map<String, dynamic>);
    } else if (source is List<dynamic>) {
      return PradeshModel.fromList(source);
    } else {
      throw ArgumentError('Invalid source type for PradeshModel.fromJson');
    }
  }

  factory PradeshModel.fromMap(Map<String, dynamic> map) {
    return PradeshModel(
      data: List<DataModel>.from(
        map['data'].map<DataModel>(
            (x) => DataModel.fromMap(x as Map<String, dynamic>)),
      ),
    );
  }

  factory PradeshModel.fromList(List<dynamic> list) {
    return PradeshModel(
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
  String toString() => 'PradeshModel(data: $data)';

  map(Function(dynamic PradeshModel) param0) {}
}

class DataModel {
  int id;
  String name;
  DataModel({
    required this.id,
    required this.name,
  });

  DataModel copyWith({
    int? id,
    String? name,
  }) {
    return DataModel(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory DataModel.fromMap(Map<String, dynamic> map) {
    return DataModel(
      id: map['id'] as int,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory DataModel.fromJson(String source) =>
      DataModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'DataModel(id: $id, name: $name)';

  @override
  bool operator ==(covariant DataModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
