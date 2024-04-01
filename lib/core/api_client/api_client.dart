import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shramsansar/core/api_const/api_const.dart';
import 'package:shramsansar/core/dbclient.dart';

class ApiClient {
  final DbClient dbClient;
  ApiClient(this.dbClient);

  Future request({
    required String path,
    String type = 'get',
    String token = '',
    Map<String, dynamic> data = const {},
  }) async {
    final dbResult =
        token.isEmpty ? await dbClient.getData(dbKey: 'token') : token;
    final Dio dio = Dio(BaseOptions(baseUrl: ApiConst.BASE_URL, headers: {
      'Authorization': 'Bearer $dbResult',
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    }));
    try {
      log(ApiConst.BASE_URL + path);
      final result = type == 'get'
          ? await dio.get(path)
          : await dio.post(path, data: data);
      return result.data;
    } on DioError catch (e) {
      throw (e.message ?? 'Unknown Error');
    }
  }

  Future requestFormData(
      {required String path,
      String token = '',
      required FormData formData}) async {
    final String dbResult =
        token.isEmpty ? await dbClient.getData(dbKey: "token") : token;
    final Dio dio = Dio(BaseOptions(baseUrl: ApiConst.BASE_URL, headers: {
      'Content-type': 'application/json',
      'Authorization': "Bearer $dbResult",
      'Accept': 'application/json'
    }));
    try {
      final result = await dio.post(path, data: formData);
      return result.data;
    } on DioError catch (e) {
      throw e.message!;
    }
  }
}

final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient(ref.read(dbClientprovider));
});
