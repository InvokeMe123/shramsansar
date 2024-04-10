import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shramsansar/core/api_client/api_client.dart';
import 'package:shramsansar/core/api_const/api_const.dart';
import 'package:shramsansar/features/trainings/data/models/training_model/training_model.dart';

abstract class LatestTrainingDS {
  Future<TrainingModel> getLatestTraining();
}

class LatestTrainingDSImpl implements LatestTrainingDS {
  final ApiClient apiClient;
  LatestTrainingDSImpl(this.apiClient);

  @override
  Future<TrainingModel> getLatestTraining() async {
    final result =
        await apiClient.request(path: ApiConst.LATEST_TRAINING, type: 'get');

    return TrainingModel.fromJson(result);
  }
}

final latestTrainingDSProvider = Provider<LatestTrainingDS>(
    (ref) => LatestTrainingDSImpl(ref.read(apiClientProvider)));
