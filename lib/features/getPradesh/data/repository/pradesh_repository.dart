import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shramsansar/core/app_error/app_error.dart';
import 'package:shramsansar/features/getPradesh/data/data_source/pradesh_data_source.dart';
import 'package:shramsansar/features/getPradesh/data/models/pradeshModel.dart';

abstract class PradeshRepo {
  Future<Either<AppError, PradeshModel>> pradeshRepo();
}

class PradeshRepoImp implements PradeshRepo {
  final PradeshDataSource pradeshDataSource;
  PradeshRepoImp(this.pradeshDataSource);
  @override
  Future<Either<AppError, PradeshModel>> pradeshRepo() async {
    try {
      final result = await pradeshDataSource.pradeshDs();
      return Right(result);
    } on DioException catch (e) {
      return Left(AppError(e.message!));
    }
  }
}

final pradeshRepoProvider = Provider<PradeshRepo>((ref) {
  return PradeshRepoImp(ref.read(pradeshDataSourceProvider));
});
