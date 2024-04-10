import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shramsansar/core/api_client/api_client.dart';
import 'package:shramsansar/core/api_const/api_const.dart';

abstract class ApplyForTrainingDS {
  Future<String> applyForTrainingDS({required String trainingID});
}

class ApplyForTrainingDSImpl implements ApplyForTrainingDS {
  final ApiClient apiClient;
  ApplyForTrainingDSImpl(this.apiClient);

  @override
  Future<String> applyForTrainingDS({required String trainingID}) async {
    final result = await apiClient.request(
      path:
          "${ApiConst.TRAINING_APPLLAY_F}$trainingID${ApiConst.TRAINING_APPLLAY_L}",
      type: 'post',
    );

    debugPrint("Apply result: $result");
    return result["message"];
  }
}

final applyForTrainingDSProvider = Provider<ApplyForTrainingDS>(
    (ref) => ApplyForTrainingDSImpl(ref.read(apiClientProvider)));
