import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shramsansar/core/api_client/api_client.dart';
import 'package:shramsansar/core/api_const/api_const.dart';
import 'package:shramsansar/features/all_jobs/data/models/all_jobs_model.dart';

abstract class AllJobsDataSource {
  Future<AllJobsModel> allJobDS();
  Future<AllJobsModel> addJobs();
}

class AllJobsDataSourceImp implements AllJobsDataSource {
  final ApiClient apiClient;
  AllJobsDataSourceImp(this.apiClient);

  @override
  Future<AllJobsModel> allJobDS() async {
    final result =
        await apiClient.request(path: ApiConst.VIEW_ALL_JOBS, type: 'get');
    log(result['data'].toString());
    return AllJobsModel.fromJson(result['data']);
  }

  @override
  Future<AllJobsModel> addJobs() async {
    log('ds of jobs');
    final result =
        await apiClient.request(path: ApiConst.VIEW_ALL_JOBS, type: 'get');
    return AllJobsModel.fromJson(result['data']);
  }
}

final allJobsDataSourceProvider = Provider<AllJobsDataSource>((ref) {
  return AllJobsDataSourceImp(ref.read(apiClientProvider));
});
