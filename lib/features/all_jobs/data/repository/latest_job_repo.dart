import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shramsansar/core/app_error/app_error.dart';
import 'package:shramsansar/features/all_jobs/data/data_source/latest_job_data_source.dart';
import 'package:shramsansar/features/all_jobs/data/models/latest_job_model.dart';

abstract class LatestJobRepo {
  Future<Either<AppError, LatestJobModel>> getLatestJobRepo();
}

class LatestJobRepoImp implements LatestJobRepo {
  final LatestJobDs latestJobDs;
  LatestJobRepoImp(this.latestJobDs);
  @override
  Future<Either<AppError, LatestJobModel>> getLatestJobRepo() async {
    log('repo of latestJobs');
    try {
      final result = await latestJobDs.getLatestJobDs();
      return Right(result);
    } on DioException catch (e) {
      return Left(AppError(e.message!));
    }
  }
}
final latestJobRepoProvider = Provider<LatestJobRepo>((ref) {
  return LatestJobRepoImp(ref.read(latestJobDsProvider));
});