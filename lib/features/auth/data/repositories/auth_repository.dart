import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shramsansar/core/app_error/app_error.dart';
import 'package:shramsansar/features/auth/data/data_source/auth_data_source.dart';
import 'package:shramsansar/features/auth/data/models/login_model.dart/login_request_model.dart';
import 'package:shramsansar/features/auth/data/models/login_model.dart/login_response_model.dart';
import 'package:shramsansar/features/auth/data/models/register_model.dart/register_request_model.dart';
import 'package:shramsansar/features/auth/data/models/register_model.dart/register_response_model.dart';

abstract class AuthRepo {
  Future<Either<AppError, LoginResponseModel>> loginRepo(
      LoginRequestModel loginRequestModel, String token);
  Future<Either<AppError, LoginResponseModel>> registerRepo(
      RegisterRequestModel registerRequestModel);
}

class AuthRepoImp implements AuthRepo {
  final AuthDataSource authDataSource;
  AuthRepoImp(this.authDataSource);

  @override
  Future<Either<AppError, LoginResponseModel>> loginRepo(
      LoginRequestModel loginRequestModel, String token) async {
    log('AuthRepo');
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
}

final authRepoProvider = Provider<AuthRepo>((ref) {
  return AuthRepoImp(ref.read(authDataSourceProvider));
});
