
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shramsansar/core/app_error/app_error.dart';
import 'package:shramsansar/features/edit_profile/data/models/education_model/education_model_req.dart';
import 'package:shramsansar/features/profile/data/data_source/profile_ds.dart';
import 'package:shramsansar/features/profile/data/model/profile_model.dart';

abstract class ProfileRepo {
  Future<Either<AppError, MyProfileModel>> profileRepo();
  Future<Either<AppError, String>> updateAboutMe(Map<String, String> data);
  Future<Either<AppError, void>> addEducation(EducationReqModel model);
  Future<Either<AppError, void>> deleteEducation(int educationID);
  Future<Either<AppError, void>> updateEducation(
      int educationID, EducationReqModel data);
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

  @override
  Future<Either<AppError, void>> addEducation(EducationReqModel model) async {
    try {
      await profileDataSource.addEducation(model);
      return const Right(null);
    } on DioException catch (e) {
      return Left(AppError(e.message!.toString()));
    }
  }

  @override
  Future<Either<AppError, void>> deleteEducation(int educationID) async {
    try {
      await profileDataSource.deleteEducation(educationID);
      return const Right(null);
    } on DioException catch (e) {
      return Left(AppError(e.message!.toString()));
    }
  }

  @override
  Future<Either<AppError, void>> updateEducation(
      int educationID, EducationReqModel data) async {
    try {
      await profileDataSource.updateEducation(educationID, data);
      return const Right(null);
    } on DioException catch (e) {
      return Left(AppError(e.message!.toString()));
    }
  }
}

final profileRepoProvider = Provider<ProfileRepo>((ref) {
  return ProfileRepoImp(ref.read(profileDataSourceProvider));
});
