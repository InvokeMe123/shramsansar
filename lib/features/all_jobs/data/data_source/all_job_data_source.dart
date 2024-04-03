import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shramsansar/core/api_client/api_client.dart';
import 'package:shramsansar/core/api_const/api_const.dart';
import 'package:shramsansar/features/all_jobs/data/models/all_jobs_model.dart';

abstract class AllJobsDataSource {
  Future<AllJobsModel> getallJobDS(int pageIndex);
  Future<AllJobsModel> searchJobDS(
      {required String muniID, required String categoryID});
}

class AllJobsDataSourceImp implements AllJobsDataSource {
  final ApiClient apiClient;
  AllJobsDataSourceImp(this.apiClient);

  @override
  Future<AllJobsModel> getallJobDS(int pageIndex) async {
    final result = await apiClient.request(
        path: "${ApiConst.VIEW_ALL_JOBS}$pageIndex", type: 'get');

    return AllJobsModel.fromJson(result);
  }

  @override
  Future<AllJobsModel> searchJobDS(
      {required String muniID, required String categoryID}) async {
    log('ds of jobs');
    final result = await apiClient.request(
        path:
            "${ApiConst.VIEW_SEARCH_JOBS}muni_id=$muniID&category_id=$categoryID",
        type: 'get');
    log("link:${ApiConst.VIEW_SEARCH_JOBS}muni_id=$muniID&category_id=$categoryID");
    return AllJobsModel.fromJson(result);
  }
}

final allJobsDataSourceProvider = Provider<AllJobsDataSource>((ref) {
  return AllJobsDataSourceImp(ref.read(apiClientProvider));
});
