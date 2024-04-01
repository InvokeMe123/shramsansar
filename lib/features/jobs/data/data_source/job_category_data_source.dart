import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shramsansar/core/api_client/api_client.dart';
import 'package:shramsansar/core/api_const/api_const.dart';
import 'package:shramsansar/features/jobs/data/models/job_category_model.dart';

abstract class JobDataSource {
  Future<JobCategoryModel> jobDS();
}

class JobDataSourceImp implements JobDataSource {
  final ApiClient apiClient;
  JobDataSourceImp(this.apiClient);
  @override
  Future<JobCategoryModel> jobDS() async {
    final result =
        await apiClient.request(path: ApiConst.CATEGORY, type: 'get');
    return JobCategoryModel.fromJson(result['data']);
  }
}

final jobdatasourceProvider = Provider<JobDataSource>((ref) {
  return JobDataSourceImp(ref.read(apiClientProvider));
});
