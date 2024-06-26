
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shramsansar/core/app_error/app_error.dart';
import 'package:shramsansar/features/auth/data/data_source/auth_data_source.dart';
import 'package:shramsansar/features/auth/data/models/change_password_model/change_password_req_model.dart';
import 'package:shramsansar/features/auth/data/models/change_password_model/change_password_res_model.dart';
import 'package:shramsansar/features/auth/data/models/login_model/login_request_model.dart';
import 'package:shramsansar/features/auth/data/models/login_model/login_response_model.dart';
import 'package:shramsansar/features/auth/data/models/register_model/register_request_model.dart';

abstract class AuthRepo {
  Future<Either<AppError, LoginResponseModel>> loginRepo(
      LoginRequestModel loginRequestModel, String token);
  Future<Either<AppError, LoginResponseModel>> registerRepo(
      RegisterRequestModel registerRequestModel);

  Future<Either<AppError, LoginResponseModel>> registerWithFormData(
      FormData formData);
  Future<Either<AppError, ChangePasswordResModel>> changePasswordRepo(
      ChangePasswordReqModel changePasswordReqModel);
}

class AuthRepoImp implements AuthRepo {
  final AuthDataSource authDataSource;
  AuthRepoImp(this.authDataSource);

  @override
  Future<Either<AppError, LoginResponseModel>> loginRepo(
      LoginRequestModel loginRequestModel, String token) async {
    try {
      final result = await authDataSource.loginDS(loginRequestModel, token);

      return Right(result);
    } on DioException catch (e) {
      return Left(AppError(e.message!));
    }
  }

  @override
  Future<Either<AppError, LoginResponseModel>> registerRepo(
      RegisterRequestModel registerRequestModel) async {
    try {
      final result = await authDataSource.registerDS(registerRequestModel);
      return Right(result);
    } on DioException catch (e) {
      return Left(AppError(e.message!));
    }
  }

  @override
  Future<Either<AppError, LoginResponseModel>> registerWithFormData(
      FormData formData) async {
    try {
      final result = await authDataSource.registerWithFormData(formData);
      return Right(result);
    } on DioException catch (e) {
      return Left(AppError(e.message!));
    }
  }

  @override
  Future<Either<AppError, ChangePasswordResModel>> changePasswordRepo(
      ChangePasswordReqModel changePasswordReqModel) async {
    try {
      final result =
          await authDataSource.changePasswordDs(changePasswordReqModel);
      return Right(result);
    } on DioException catch (e) {
      return Left(AppError(e.message!));
    }
  }
}

final authRepoProvider = Provider<AuthRepo>((ref) {
  return AuthRepoImp(ref.read(authDataSourceProvider));
});
