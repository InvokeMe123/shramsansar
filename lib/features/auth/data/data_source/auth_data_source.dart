import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shramsansar/core/api_client/api_client.dart';
import 'package:shramsansar/core/api_const/api_const.dart';
import 'package:shramsansar/core/dbclient.dart';
import 'package:shramsansar/features/auth/data/models/login_model.dart/login_request_model.dart';
import 'package:shramsansar/features/auth/data/models/login_model.dart/login_response_model.dart';
import 'package:shramsansar/features/auth/data/models/register_model.dart/register_request_model.dart';
import 'package:shramsansar/features/auth/data/models/register_model.dart/register_response_model.dart';

abstract class AuthDataSource {
  Future<LoginResponseModel> loginDS(
      LoginRequestModel loginRequestModel, String token);
  Future<LoginResponseModel> registerDS(
      RegisterRequestModel registerRequestModel, String token);
}

class AuthDataSourceImp implements AuthDataSource {
  final ApiClient apiClient;
  AuthDataSourceImp(this.apiClient);
  @override
  Future<LoginResponseModel> loginDS(
      LoginRequestModel loginRequestModel, String token) async {
    log('authDS');

    final result = await apiClient.request(
        path: ApiConst.LOGIN_URI,
        token: token,
        type: 'post',
        data: loginRequestModel.toMap());
    DbClient().setData(dbKey: 'token', value: result['token']);
    log(result['token']);

    return LoginResponseModel.fromJson(result['token']);
  }

  @override
  Future<LoginResponseModel> registerDS(
      RegisterRequestModel registerRequestModel, String token) async {
    final result = await apiClient.request(
        path: ApiConst.REGISTER,
        token: token,
        type: 'post',
        data: registerRequestModel.toMap());
    return LoginResponseModel.fromJson(result['token']);
  }
}

final authDataSourceProvider = Provider<AuthDataSource>((ref) {
  return AuthDataSourceImp(ref.read(apiClientProvider));
});
