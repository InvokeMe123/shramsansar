import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shramsansar/core/app_error/app_error.dart';
import 'package:shramsansar/features/all_jobs/data/data_source/all_job_data_source.dart';
import 'package:shramsansar/features/all_jobs/data/models/all_jobs_model.dart';

abstract class AllJobsRepo {
  Future<Either<AppError, AllJobsModel>> allJobsRepo(int pageId, int? muniId,
      int? categoryId, int? pradeshId, int? districtId);
  Future<Either<AppError, AllJobsModel>> addAllJobs();
}

class AllJobsRepoImp implements AllJobsRepo {
  final AllJobsDataSource allJobsDataSource;
  AllJobsRepoImp(this.allJobsDataSource);

  @override
  Future<Either<AppError, AllJobsModel>> allJobsRepo(int pageId, int? muniId,
      int? categoryId, int? pradeshId, int? districtId) async {
    try {
      final result = await allJobsDataSource.allJobDS();
      return Right(result);
    } on DioException catch (e) {
      return Left(AppError(e.message!));
    }
  }

  @override
  Future<Either<AppError, AllJobsModel>> addAllJobs() async {
    log('repo of jobs');
    try {
      final result = await allJobsDataSource.addJobs();
      return Right(result);
    } on DioException catch (e) {
      return Left(AppError(e.message!));
    }
  }
}

final allJobsRepoProvider = Provider<AllJobsRepo>((ref) {
  return AllJobsRepoImp(ref.read(allJobsDataSourceProvider));
});
