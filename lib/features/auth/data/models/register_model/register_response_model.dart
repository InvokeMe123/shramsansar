class RegisterResponseModel {
  RegisterResponseModel({
    required String token,
  }) : _token = token;

  factory RegisterResponseModel.fromJson(dynamic json) {
    if (json is String) {
      return RegisterResponseModel(token: json);
    } else if (json is Map<String, dynamic>) {
      return RegisterResponseModel(token: json['token']);
    } else {
      throw const FormatException("Invalid JSON format");
    }
  }

  String _token;

  String get token => _token;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {'token': _token};
    return map;
  }
}
