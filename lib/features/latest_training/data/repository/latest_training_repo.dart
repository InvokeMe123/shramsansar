import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shramsansar/core/app_error/app_error.dart';
import 'package:shramsansar/features/latest_training/data/data_source/latest_training_ds.dart';
import 'package:shramsansar/features/trainings/data/models/training_model/training_model.dart';

abstract class LatestTrainingRepo {
  Future<Either<AppError, TrainingModel>> getLatestTrainingRepo();
}

class LatestTrainingRepoImpl implements LatestTrainingRepo {
  final LatestTrainingDS latestTrainingDS;

  LatestTrainingRepoImpl(this.latestTrainingDS);

  @override
  Future<Either<AppError, TrainingModel>> getLatestTrainingRepo() async {
    try {
      final result = await latestTrainingDS.getLatestTraining();
      return Right(result);
    } on Exception catch (e) {
      return Left(AppError(e.toString()));
    }
  }
}

final latestTrainingRepoProvider = Provider<LatestTrainingRepo>(
    (ref) => LatestTrainingRepoImpl(ref.read(latestTrainingDSProvider)));
