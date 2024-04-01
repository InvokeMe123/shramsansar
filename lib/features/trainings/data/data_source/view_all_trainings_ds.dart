import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shramsansar/core/api_client/api_client.dart';
import 'package:shramsansar/core/api_const/api_const.dart';
import 'package:shramsansar/features/trainings/data/models/training_model/training_model.dart';

abstract class ViewAllTrainingDS {
  Future<TrainingModel> getAllTrainingDS();
}

class ViewAllTrainingDSImpl implements ViewAllTrainingDS {
  final ApiClient apiClient;
  ViewAllTrainingDSImpl(this.apiClient);

  @override
  Future<TrainingModel> getAllTrainingDS() async {
    final result = await apiClient.request(
        path: "${ApiConst.VIEW_ALL_TRAININGS}1", type: 'get');

    return TrainingModel.fromJson(result);
  }
}

final viewAllTrainingProvider = Provider<ViewAllTrainingDS>(
    (ref) => ViewAllTrainingDSImpl(ref.read(apiClientProvider)));
