import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shramsansar/core/api_client/api_client.dart';
import 'package:shramsansar/core/api_const/api_const.dart';
import 'package:shramsansar/features/edit_profile/data/models/experience_model/experience_model.dart';

abstract class TrainingCertificationDs {
  Future<void> addTraining(FormData formData);
  Future<void> deleteTraining(int id);
  Future<void> editTraining(int id, FormData formData);
}

class TrainingCertificationDsImp implements TrainingCertificationDs {
  final ApiClient apiClient;
  TrainingCertificationDsImp(this.apiClient);

  @override
  Future<void> addTraining(FormData formData) async {
    final result = await apiClient.requestFormData(
      path: ApiConst.POST_TRANINGS,
      formData: formData,
    );
    log(result.toString());
  }

  @override
  Future<void> deleteTraining(int id) async {
    final del = await apiClient.request(
        path: "${ApiConst.DELETE_TRANINGS}$id", type: 'get');
    log(del.toString());
  }

  @override
  Future<void> editTraining(int id, FormData formData) async {
    final edit = await apiClient.requestFormData(
        path: "${ApiConst.UPDATE_TRANINGS}$id",
        formData: formData
       );
    log(edit.toString());
  }
}

final trainingCertificationDsProvider = Provider<TrainingCertificationDs>((ref) {
  return TrainingCertificationDsImp(ref.read(apiClientProvider));
});
