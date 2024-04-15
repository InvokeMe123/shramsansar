import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shramsansar/core/api_client/api_client.dart';
import 'package:shramsansar/core/api_const/api_const.dart';
import 'package:shramsansar/core/dbclient.dart';
import 'package:shramsansar/features/auth/data/models/change_password_model/change_password_req_model.dart';
import 'package:shramsansar/features/auth/data/models/change_password_model/change_password_res_model.dart';
import 'package:shramsansar/features/auth/data/models/login_model/login_request_model.dart';
import 'package:shramsansar/features/auth/data/models/login_model/login_response_model.dart';
import 'package:shramsansar/features/auth/data/models/register_model/register_request_model.dart';

abstract class AuthDataSource {
  Future<LoginResponseModel> loginDS(
      LoginRequestModel loginRequestModel, String token);
  Future<LoginResponseModel> registerDS(
      RegisterRequestModel registerRequestModel);
  Future<ChangePasswordResModel> changePasswordDs(
      ChangePasswordReqModel changePasswordReqModel);
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
      RegisterRequestModel registerRequestModel) async {
    final result = await apiClient.request(
        path: ApiConst.REGISTER,
        type: 'post',
        data: registerRequestModel.toMap());
    DbClient().setData(dbKey: 'token', value: result['token']);
    return LoginResponseModel.fromJson(result['token']);
  }

  @override
  Future<ChangePasswordResModel> changePasswordDs(
      ChangePasswordReqModel changePasswordReqModel) async {
    final result = await apiClient.request(
        path: ApiConst.CHNAGE_PASSWORD,
        type: 'post',
        data: changePasswordReqModel.toJson());
    return ChangePasswordResModel.fromJson(result);
  }
}

final authDataSourceProvider = Provider<AuthDataSource>((ref) {
  return AuthDataSourceImp(ref.read(apiClientProvider));
});
