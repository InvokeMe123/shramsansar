import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shramsansar/core/api_client/api_client.dart';
import 'package:shramsansar/core/api_const/api_const.dart';
import 'package:shramsansar/core/app_error/app_error.dart';
import 'package:shramsansar/features/edit_profile/data/data_source/education_data_source/education_drop_data_source.dart';
import 'package:shramsansar/features/edit_profile/data/models/education_model/education_model.dart';

abstract class EducationRepo {
  Future<Either<AppError, EducationModel>> educationDropRepo();
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
}

final educationRepoProvider = Provider<EducationRepo>((ref) {
  return EducationRepoImp(ref.read(educationDSProvider));
});
