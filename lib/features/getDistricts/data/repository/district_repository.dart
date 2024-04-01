import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shramsansar/core/app_error/app_error.dart';
import 'package:shramsansar/features/getDistricts/data/data_source/district_data_source.dart';
import 'package:shramsansar/features/getDistricts/data/models/district_model.dart';

abstract class DistrictRepo {
  Future<Either<AppError, DistrictModel>> getDistrictRepo();
}

class DistrictRepoImp implements DistrictRepo {
  final DistrictDataSource districtDS;
  DistrictRepoImp(this.districtDS);

  @override
  Future<Either<AppError, DistrictModel>> getDistrictRepo( ) async {
    try {
      final result = await districtDS.getDistrictDS();
      return Right(result);
    } on DioException catch (e) {
      return Left(AppError(e.message!));
    }
  }
}

final districtRepoProvider = Provider<DistrictRepo>((ref) {
  return DistrictRepoImp(ref.read(districtDataSourceProvider));
});
