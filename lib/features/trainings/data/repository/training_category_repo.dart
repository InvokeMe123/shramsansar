import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shramsansar/core/app_error/app_error.dart';
import 'package:shramsansar/features/trainings/data/data_source/training_category_data_source.dart';
import 'package:shramsansar/features/trainings/data/models/training_category_model/training_category_model.dart';

abstract class TrainingCategoryRepo {
  Future<Either<AppError, TrainingCategoryModel>> fetch();
}

class TrainingCategoryRepoImpl implements TrainingCategoryRepo {
  final TrainingCategoryDataSource source;
  TrainingCategoryRepoImpl(this.source);
  @override
  Future<Either<AppError, TrainingCategoryModel>> fetch() async {
    try {
      final result = await source.fetch();
      return Right(result);
    } on DioException catch (e) {
      return Left(AppError(e.message!));
    }
  }
}

final trainingCategoryRepoProvider = Provider<TrainingCategoryRepo>((ref) {
  return TrainingCategoryRepoImpl(ref.read(trainingCategoryDataSourceProvider));
});
