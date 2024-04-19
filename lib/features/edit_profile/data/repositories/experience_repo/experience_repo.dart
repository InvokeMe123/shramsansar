import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shramsansar/core/app_error/app_error.dart';
import 'package:shramsansar/features/edit_profile/data/data_source/experience_data_source/experience_data_source.dart';

abstract class ExperienceRepo {
  Future<Either<AppError, void>> experienceRepo(FormData formData);
  Future<Either<AppError, void>> deleteExperinceRepo(int id);
  Future<Either<AppError, void>> editExperinceRepo(int id, FormData formData);
}

class ExperienceRepoImp implements ExperienceRepo {
  final ExperienceDs experienceDs;
  ExperienceRepoImp(this.experienceDs);

  @override
  Future<Either<AppError, void>> experienceRepo(FormData formData) async {
    try {
      final result = await experienceDs.addExperience(formData);
      return Right(result);
    } on DioException catch (e) {
      return Left(AppError(e.message!));
    }
  }

  @override
  Future<Either<AppError, void>> deleteExperinceRepo(int id) async {
    try {
      final result = await experienceDs.deleteExperience(id);
      return Right(result);
    } on DioException catch (e) {
      return Left(AppError(e.message!));
    }
  }
  @override 
   Future<Either<AppError, void>> editExperinceRepo(int id, FormData formData)async{
    try {
      final result = await experienceDs.editExperience(id,formData);
      return Right(result);
    } on DioException catch (e) {
      return Left(AppError(e.message!));
    }

   }

}

final experienceRepoProvider = Provider<ExperienceRepo>((ref) {
  return ExperienceRepoImp(ref.read(experienceDSProvider));
});
