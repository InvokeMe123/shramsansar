import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shramsansar/core/api_client/api_client.dart';
import 'package:shramsansar/core/api_const/api_const.dart';
import 'package:shramsansar/features/all_jobs/data/models/latest_job_model.dart';

abstract class LatestJobDs {
  Future<LatestJobModel> getLatestJobDs();
}

class LatestJobDsImp implements LatestJobDs {
  final ApiClient apiClient;
  LatestJobDsImp(this.apiClient);
  @override
  Future<LatestJobModel> getLatestJobDs() async {
    log('DS of LatestJobs');
    final result = await apiClient.request(path: ApiConst.Latest_Job);

    return LatestJobModel.fromJson(result);
  }
}

final latestJobDsProvider = Provider<LatestJobDs>((ref) {
  return LatestJobDsImp(ref.read(apiClientProvider));
});
