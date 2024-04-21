// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';


class MunicipalityModel {
  List<DataModel> data;

  MunicipalityModel({
    required this.data,
  });

  factory MunicipalityModel.fromJson(dynamic source) {
    if (source is String) {
      return MunicipalityModel.fromMap(
          json.decode(source) as Map<String, dynamic>);
    } else if (source is List<dynamic>) {
      return MunicipalityModel.fromList(source);
    } else {
      throw ArgumentError('Invalid source type for MunicipalityModel.fromJson');
    }
  }

  factory MunicipalityModel.fromMap(Map<String, dynamic> map) {
    return MunicipalityModel(
      data: List<DataModel>.from(
        map['data'].map<DataModel>(
            (x) => DataModel.fromMap(x as Map<String, dynamic>)),
      ),
    );
  }

  factory MunicipalityModel.fromList(List<dynamic> list) {
    return MunicipalityModel(
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
  String toString() => 'MunicipalityModel(data: $data)';

  map(Function(dynamic MunicipalityModel) param0) {}
}

class DataModel {
  int muni_id;
  int type;
  int district_id;
  String name;
  String code;
  DataModel({
    required this.muni_id,
    required this.type,
    required this.district_id,
    required this.name,
    required this.code,
  });

  DataModel copyWith({
    int? muni_id,
    int? type,
    int? district_id,
    String? name,
    String? code,
  }) {
    return DataModel(
      muni_id: muni_id ?? this.muni_id,
      type: type ?? this.type,
      district_id: district_id ?? this.district_id,
      name: name ?? this.name,
      code: code ?? this.code,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'muni_id': muni_id,
      'type': type,
      'district_id': district_id,
      'name': name,
      'code': code,
    };
  }

  factory DataModel.fromMap(Map<String, dynamic> map) {
    return DataModel(
      muni_id: map['muni_id'] as int,
      type: map['type'],
      district_id: map['district_id'],
      name: map['name'] as String,
      code: map['code'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory DataModel.fromJson(String source) =>
      DataModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DataModel(muni_id: $muni_id, type: $type, district_id: $district_id, name: $name, code: $code)';
  }

  @override
  bool operator ==(covariant DataModel other) {
    if (identical(this, other)) return true;

    return other.muni_id == muni_id &&
        other.type == type &&
        other.district_id == district_id &&
        other.name == name &&
        other.code == code;
  }

  @override
  int get hashCode {
    return muni_id.hashCode ^
        type.hashCode ^
        district_id.hashCode ^
        name.hashCode ^
        code.hashCode;
  }
}
