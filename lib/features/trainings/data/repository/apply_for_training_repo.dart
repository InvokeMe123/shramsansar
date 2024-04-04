import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shramsansar/core/app_error/app_error.dart';
import 'package:shramsansar/features/trainings/data/data_source/apply_for_training_ds.dart';

abstract class ApplyForTrainingRepo {
  Future<Either<AppError, String>> applyForTrainingRepo(
      {required String trainingID});
}

class ApplyForTrainingRepoImpl implements ApplyForTrainingRepo {
  ApplyForTrainingDS applyForTrainingDS;

  ApplyForTrainingRepoImpl(this.applyForTrainingDS);

  @override
  Future<Either<AppError, String>> applyForTrainingRepo(
      {required String trainingID}) async {
    try {
      final message =
          await applyForTrainingDS.applyForTrainingDS(trainingID: trainingID);
      return Right(message);
    } catch (e) {
      return Left(AppError(e.toString()));
    }
  }
}

final applyForTrainingRepoProvider = Provider<ApplyForTrainingRepo>(
    (ref) => ApplyForTrainingRepoImpl(ref.read(applyForTrainingDSProvider)));
