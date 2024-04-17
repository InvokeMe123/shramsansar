import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shramsansar/core/api_client/api_client.dart';
import 'package:shramsansar/core/api_const/api_const.dart';
import 'package:shramsansar/core/app_error/app_error.dart';
import 'package:shramsansar/features/edit_profile/data/data_source/education_data_source/education_drop_data_source.dart';
import 'package:shramsansar/features/edit_profile/data/models/education_model/education_model.dart';
import 'package:shramsansar/features/edit_profile/data/models/education_model/education_model_req.dart';
import 'package:shramsansar/features/edit_profile/data/models/education_model/education_res_model.dart';

abstract class EducationRepo {
  Future<Either<AppError, EducationModel>> educationDropRepo();
  Future<Either<AppError, EducationResModel>> educationAddRepo(
      EducationReqModel educationReqModel);
  Future<Either<AppError, EducationResModel>> educationDeleteRepo(int id);
}

class EducationRepoImp implements EducationRepo {
  final EducationDs educationDs;
  EducationRepoImp(this.educationDs);

  @override
  Future<Either<AppError, EducationModel>> educationDropRepo() async {
    try {
      final result = await educationDs.educationDropDs();
      return Right(result);
    } on DioException catch (e) {
      return Left(AppError(e.message!));
    }
  }

  @override
  Future<Either<AppError, EducationResModel>> educationAddRepo(
      EducationReqModel educationReqModel) async {
    try {
      final result = await educationDs.educationAdd(educationReqModel);
      return Right(result);
    } on DioException catch (e) {
      return Left(AppError(e.message!));
    }
  }

  @override
  Future<Either<AppError, EducationResModel>> educationDeleteRepo(
      int id) async {
    try {
      final result = await educationDs.educationDelete(id);
      return Right(result);
    } on DioException catch (e) {
      return Left(AppError(e.message!));
    }
  }
}

final educationRepoProvider = Provider<EducationRepo>((ref) {
  return EducationRepoImp(ref.read(educationDSProvider));
});
