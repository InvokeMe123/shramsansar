import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shramsansar/core/app_error/app_error.dart';
import 'package:shramsansar/features/trainings/data/data_source/view_all_trainings_ds.dart';
import 'package:shramsansar/features/trainings/data/models/training_model/training_model.dart';

abstract class ViewAllTrainingRepository {
  Future<Either<AppError, TrainingModel>> getAllTrainingRepo();
}

class ViewAllTrainingRepositoryImpl implements ViewAllTrainingRepository {
  final ViewAllTrainingDS viewAllTrainingDS;

  ViewAllTrainingRepositoryImpl(this.viewAllTrainingDS);

  @override
  Future<Either<AppError, TrainingModel>> getAllTrainingRepo() async {
    try {
      final result = await viewAllTrainingDS.getAllTrainingDS();
      return Right(result);
    } on DioException catch (e) {
      return Left(AppError(e.message.toString()));
    }
  }
}

final viewAllTrainingRepositoryProvider = Provider<ViewAllTrainingRepository>(
    (ref) => ViewAllTrainingRepositoryImpl(ref.read(viewAllTrainingProvider)));
