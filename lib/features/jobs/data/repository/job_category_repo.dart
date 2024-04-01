import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shramsansar/core/app_error/app_error.dart';
import 'package:shramsansar/features/jobs/data/data_source/job_category_data_source.dart';
import 'package:shramsansar/features/jobs/data/models/job_category_model.dart';

abstract class JobCategoryRepo {
  Future<Either<AppError, JobCategoryModel>> getJobCatergory();
}

class JobCategoryRepoImp implements JobCategoryRepo {
  final JobDataSource jobDataSource;
  JobCategoryRepoImp(this.jobDataSource);
  @override
  Future<Either<AppError, JobCategoryModel>> getJobCatergory() async {
    try {
      final result = await jobDataSource.jobDS();
      return Right(result);
    } on DioException catch (e) {
      return Left(AppError(e.message!));
    }
  }
}

final jobcategoryRepoProvider = Provider<JobCategoryRepo>((ref) {
  return JobCategoryRepoImp(ref.read(jobdatasourceProvider));
});
