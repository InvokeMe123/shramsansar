import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shramsansar/core/api_client/api_client.dart';
import 'package:shramsansar/core/api_const/api_const.dart';
import 'package:shramsansar/features/trainings/data/models/training_model/training_model.dart';

abstract class ViewAllTrainingDS {
  Future<TrainingModel> getAllTrainingDS(int pageIndex);

  Future<TrainingModel> searchTrainingDS(
      {required String muniID, required String categoryID});
}

class ViewAllTrainingDSImpl implements ViewAllTrainingDS {
  final ApiClient apiClient;
  ViewAllTrainingDSImpl(this.apiClient);

  @override
  Future<TrainingModel> getAllTrainingDS(int pageIndex) async {
    final result = await apiClient.request(
        path: "${ApiConst.VIEW_ALL_TRAININGS}$pageIndex", type: 'get');

    return TrainingModel.fromJson(result);
  }

  @override
  Future<TrainingModel> searchTrainingDS(
      {required String muniID, required String categoryID}) async {
    final result = await apiClient.request(
        path:
            "${ApiConst.VIEW_SEARCH_TRAINING}?muni_id=$muniID&category_id=$categoryID",
        type: 'get');

    debugPrint(
        "LInk: ${ApiConst.VIEW_SEARCH_TRAINING}?muni_id=$muniID&category_id=$categoryID}");

    return TrainingModel.fromJson(result);
  }
}

final viewAllTrainingDSProvider = Provider<ViewAllTrainingDS>(
    (ref) => ViewAllTrainingDSImpl(ref.read(apiClientProvider)));
