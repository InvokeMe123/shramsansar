import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shramsansar/core/api_client/api_client.dart';
import 'package:shramsansar/core/api_const/api_const.dart';
import 'package:shramsansar/features/training_center/data/model/training_centers_model.dart';

abstract class TrainingCentersDS {
  Future<TrainingCentersModel> getTrainingCenters(int pageIndex);
}

class TrainingCentersDsImpl implements TrainingCentersDS {
  final ApiClient apiClient;
  TrainingCentersDsImpl(this.apiClient);

  @override
  Future<TrainingCentersModel> getTrainingCenters(int pageIndex) async {
    final result = await apiClient.request(
        path: ApiConst.VIEW_ALL_Tsp + pageIndex.toString());

    return TrainingCentersModel.fromJson(result);
  }
}

final trainingCentersDsProvider = Provider<TrainingCentersDS>(
    (ref) => TrainingCentersDsImpl(ref.read(apiClientProvider)));
