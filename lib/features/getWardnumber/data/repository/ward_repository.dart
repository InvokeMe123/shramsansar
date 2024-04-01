import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shramsansar/core/app_error/app_error.dart';
import 'package:shramsansar/features/getWardnumber/data/data_source/ward_data_source.dart';
import 'package:shramsansar/features/getWardnumber/data/models/ward_model.dart';

abstract class WardRepo {
  Future<Either<AppError, WardModel>> wardRepo();
}

class WardRepoImp implements WardRepo {
  final WardDataSource wardDataSource;
  WardRepoImp(this.wardDataSource);

  @override
  Future<Either<AppError, WardModel>> wardRepo() async {
    try {
      final result = await wardDataSource.wardDS();
      return Right(result);
    } on DioException catch (e) {
      return Left(AppError(e.message!));
    }
  }
}
final wardRepoProvider = Provider<WardRepo>((ref) {
  return WardRepoImp(ref.read(wardDataSourceProvider));
});