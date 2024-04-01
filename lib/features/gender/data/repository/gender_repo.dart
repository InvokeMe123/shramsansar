import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shramsansar/core/app_error/app_error.dart';
import 'package:shramsansar/features/gender/data/data_source/gender_data_source.dart';
import 'package:shramsansar/features/gender/data/models/gender_model.dart';

abstract class GenderRepo {
  Future<Either<AppError, GenderModel>> genderRepo();
}

class GenderRepoImp implements GenderRepo {
  final GenderDataSource genderDataSource;
  GenderRepoImp(this.genderDataSource);

  @override
  Future<Either<AppError, GenderModel>> genderRepo() async {
    try {
      final result = await genderDataSource.genderDS();
      return Right(result);
    } on DioException catch (e) {
      return Left(AppError(e.message ?? "unknown error"));
    }
  }
}

final genderRepoProvider = Provider<GenderRepo>((ref) {
  return GenderRepoImp(ref.read(genderDataSourceProvider));
});
