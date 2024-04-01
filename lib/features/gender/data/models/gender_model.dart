import 'dart:convert';

class GenderModel {
  List<DataModel> data;

  GenderModel({
    required this.data,
  });

  factory GenderModel.fromJson(dynamic source) {
    if (source is String) {
      return GenderModel.fromMap(json.decode(source) as Map<String, dynamic>);
    } else if (source is List<dynamic>) {
      return GenderModel.fromList(source);
    } else {
      throw ArgumentError('Invalid source type for GenderModel.fromJson');
    }
  }

  factory GenderModel.fromMap(Map<String, dynamic> map) {
    return GenderModel(
      data: List<DataModel>.from(
        map['data'].map<DataModel>(
            (x) => DataModel.fromMap(x as Map<String, dynamic>)),
      ),
    );
  }

  factory GenderModel.fromList(List<dynamic> list) {
    return GenderModel(
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
  String toString() => 'GenderModel(data: $data)';

  map(Function(dynamic genderModel) param0) {}
}

class DataModel {
  final String gender;
  final int id;

  DataModel({
    required this.gender,
    required this.id,
  });

  factory DataModel.fromMap(Map<String, dynamic> map) {
    return DataModel(
      gender: map['gender'] as String,
      id: map['id'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'gender': gender,
      'id': id,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() => 'DataModel(gender: $gender, id: $id)';
}
