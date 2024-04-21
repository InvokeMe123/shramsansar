// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';


class WardModel {
  List<DataModel> data;

  WardModel({
    required this.data,
  });

  factory WardModel.fromJson(dynamic source) {
    if (source is String) {
      return WardModel.fromMap(json.decode(source) as Map<String, dynamic>);
    } else if (source is List<dynamic>) {
      return WardModel.fromList(source);
    } else {
      throw ArgumentError('Invalid source type for WardModel.fromJson');
    }
  }

  factory WardModel.fromMap(Map<String, dynamic> map) {
    return WardModel(
      data: List<DataModel>.from(
        map['data'].map<DataModel>(
            (x) => DataModel.fromMap(x as Map<String, dynamic>)),
      ),
    );
  }

  factory WardModel.fromList(List<dynamic> list) {
    return WardModel(
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
  String toString() => 'WardModel(data: $data)';

  map(Function(dynamic WardModel) param0) {}
}

class DataModel {
  int id;
  String ward_no;
  DataModel({
    required this.id,
    required this.ward_no,
  });

  DataModel copyWith({
    int? id,
    String? ward_no,
  }) {
    return DataModel(
      id: id ?? this.id,
      ward_no: ward_no ?? this.ward_no,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'ward_no': ward_no,
    };
  }

  factory DataModel.fromMap(Map<String, dynamic> map) {
    return DataModel(
      id: map['id'] as int,
      ward_no: map['ward_no'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory DataModel.fromJson(String source) =>
      DataModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'DataModel(id: $id, ward_no: $ward_no)';

  @override
  bool operator ==(covariant DataModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.ward_no == ward_no;
  }

  @override
  int get hashCode => id.hashCode ^ ward_no.hashCode;
}
