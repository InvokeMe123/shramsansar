import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shramsansar/core/api_client/api_client.dart';
import 'package:shramsansar/core/api_const/api_const.dart';
import 'package:shramsansar/features/jobs/data/models/job_category_model.dart';
import 'package:shramsansar/features/trainings/data/models/training_category_model/training_category_model.dart';

abstract class TrainingCategoryDataSource {
  Future<TrainingCategoryModel> fetch();
}

class TrainingCategoryDSImpl implements TrainingCategoryDataSource {
  final ApiClient apiClient;
  TrainingCategoryDSImpl(this.apiClient);
  @override
  Future<TrainingCategoryModel> fetch() async {
    final result =
        await apiClient.request(path: ApiConst.TRAININGS_CATEGORY, type: 'get');
    return TrainingCategoryModel.fromJson(result);
  }
}

final trainingCategoryDataSourceProvider =
    Provider<TrainingCategoryDataSource>((ref) {
  return TrainingCategoryDSImpl(ref.read(apiClientProvider));
});
