import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shramsansar/core/app_error/app_error.dart';
import 'package:shramsansar/features/caste/data/data_source/caste_data_source.dart';
import 'package:shramsansar/features/caste/data/models/caste_model.dart';

abstract class CasteRepo {
  Future<Either<AppError, CasteModel>> casteRepo();
}

class CasteRepoImp implements CasteRepo {
  final CasteDataSource casteDataSource;
  CasteRepoImp(this.casteDataSource);
  @override
  Future<Either<AppError, CasteModel>> casteRepo() async {
    try {
      final result = await casteDataSource.casteDS();
      return Right(result);
    } on DioException catch (e) {
      return Left(AppError(e.message!));
    }
  }
}

final casteRepoProvider = Provider<CasteRepo>((ref) {
  return CasteRepoImp(ref.read(casteDataSourceProvider));
});
