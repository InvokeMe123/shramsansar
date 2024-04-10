import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shramsansar/core/app_error/app_error.dart';
import 'package:shramsansar/features/training_center/data/data_source/training_center_data_source.dart';
import 'package:shramsansar/features/training_center/data/model/training_centers_model.dart';

abstract class TrainingCenterRepo {
  Future<Either<AppError, TrainingCentersModel>> getTrainingCenters(
      int pageIndex);
}

class TrainingCenterRepoImpl implements TrainingCenterRepo {
  final TrainingCentersDS trainingCenterDs;
  TrainingCenterRepoImpl(this.trainingCenterDs);

  @override
  Future<Either<AppError, TrainingCentersModel>> getTrainingCenters(
      int pageIndex) async {
    try {
      final result = await trainingCenterDs.getTrainingCenters(pageIndex);
      return Right(result);
    } on AppError catch (e) {
      return Left(e);
    }
  }
}

final trainingCenterRepoProvider = Provider<TrainingCenterRepo>(
    (ref) => TrainingCenterRepoImpl(ref.read(trainingCentersDsProvider)));
