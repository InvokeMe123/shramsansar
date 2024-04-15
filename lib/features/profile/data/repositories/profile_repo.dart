import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shramsansar/core/app_error/app_error.dart';
import 'package:shramsansar/features/profile/data/data_source/profile_ds.dart';
import 'package:shramsansar/features/profile/data/model/profile_model.dart';

abstract class ProfileRepo {
  Future<Either<AppError, MyProfileModel>> profileRepo();
  Future<Either<AppError, String>> updateAboutMe(Map<String, String> data);
}

class ProfileRepoImp implements ProfileRepo {
  final ProfileDataSource profileDataSource;
  ProfileRepoImp(this.profileDataSource);
  @override
  Future<Either<AppError, MyProfileModel>> profileRepo() async {
    try {
      final result = await profileDataSource.getMyProfile();

      return Right(result);
    } on DioException catch (e) {
      return Left(AppError(e.message!.toString()));
    }
  }

  @override
  Future<Either<AppError, String>> updateAboutMe(
      Map<String, String> data) async {
    try {
      await profileDataSource.updateAboutMe(data);
      return Right(data["about_me"]!);
    } on DioException catch (e) {
      return Left(AppError(e.message!.toString()));
    }
  }
}

final profileRepoProvider = Provider<ProfileRepo>((ref) {
  return ProfileRepoImp(ref.read(profileDataSourceProvider));
});
