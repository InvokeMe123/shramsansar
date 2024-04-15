class LoginResponseModel {
  LoginResponseModel({
    required String token,
  }) : _token = token;

  factory LoginResponseModel.fromJson(dynamic json) {
    if (json is String) {
      return LoginResponseModel(token: json);
    } else if (json is Map<String, dynamic>) {
      return LoginResponseModel(token: json['token']);
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
