import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shramsansar/core/app_error/app_error.dart';
import 'package:shramsansar/features/edit_profile/data/data_source/training_certification_data_source/training_certification_data_source.dart';

abstract class TrainingCertificationRepo {
  Future<Either<AppError, void>> trainingCertificationRepo(FormData formData);
  Future<Either<AppError, void>> deletetrainingCertificationRepo(int id);
  Future<Either<AppError, void>> editTrainingCertificationRepo(int id, FormData formData);
}

class TrainingCertificationRepoImp implements TrainingCertificationRepo {
  final TrainingCertificationDs trainingCertificationDs;
  TrainingCertificationRepoImp(this.trainingCertificationDs);

  @override
  Future<Either<AppError, void>> trainingCertificationRepo(FormData formData) async {
    try {
      final result = await trainingCertificationDs.addTraining(formData);
      return Right(result);
    } on DioException catch (e) {
      return Left(AppError(e.message!));
    }
  }

  @override
  Future<Either<AppError, void>> deletetrainingCertificationRepo(int id) async {
    try {
      final result = await trainingCertificationDs.deleteTraining(id);
      return Right(result);
    } on DioException catch (e) {
      return Left(AppError(e.message!));
    }
  }
  @override 
   Future<Either<AppError, void>> editTrainingCertificationRepo(int id, FormData formData)async{
    try {
      final result = await trainingCertificationDs.editTraining(id,formData);
      return Right(result);
    } on DioException catch (e) {
      return Left(AppError(e.message!));
    }

   }

}

final trainingCertificationRepoProvider = Provider<TrainingCertificationRepo>((ref) {
  return TrainingCertificationRepoImp(ref.read(trainingCertificationDsProvider));
});
