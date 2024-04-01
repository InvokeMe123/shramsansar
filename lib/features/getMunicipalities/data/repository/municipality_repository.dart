import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shramsansar/core/app_error/app_error.dart';
import 'package:shramsansar/features/getMunicipalities/data/data_source/municipality_data_source.dart';
import 'package:shramsansar/features/getMunicipalities/data/models/municipality_model.dart';

abstract class MuniRepo {
  Future<Either<AppError, MunicipalityModel>> muniRepo();
}

class MuniRepoImp implements MuniRepo {
  final MuniDataSource muniDataSource;
  MuniRepoImp(this.muniDataSource);
  @override
  Future<Either<AppError, MunicipalityModel>> muniRepo() async {
    try {
      final result = await muniDataSource.muniDS();
      return Right(result);
    } on DioException catch (e) {
      return Left(AppError(e.message!));
    }
  }
}

final muniRepoProvider = Provider<MuniRepo>((ref) {
  return MuniRepoImp(ref.read(muniDSProvider));
});
