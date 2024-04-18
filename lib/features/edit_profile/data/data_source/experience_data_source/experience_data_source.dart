import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shramsansar/core/api_client/api_client.dart';
import 'package:shramsansar/core/api_const/api_const.dart';
import 'package:shramsansar/features/edit_profile/data/models/experience_model/experience_model.dart';

abstract class ExperienceDs {
  Future<void> addExperience(FormData formData);
  Future<void> deleteExperience(int id);
  Future<void> editExperience(int id, FormData formData);
}

class ExperienceDsImp implements ExperienceDs {
  final ApiClient apiClient;
  ExperienceDsImp(this.apiClient);

  @override
  Future<void> addExperience(FormData formData) async {
    final result = await apiClient.requestFormData(
      path: ApiConst.POST_EXPERINCE,
      formData: formData,
    );
    log(result.toString());
  }

  @override
  Future<void> deleteExperience(int id) async {
    final del = await apiClient.request(
        path: "${ApiConst.DELETE_EXPERINCE}$id", type: 'get');
    log(del.toString());
  }

  @override
  Future<void> editExperience(int id, FormData formData) async {
    final edit = await apiClient.requestFormData(
        path: "${ApiConst.UPDATE_EXPERINCE}$id",
        formData: formData
       );
    log(edit.toString());
  }
}

final experienceDSProvider = Provider<ExperienceDs>((ref) {
  return ExperienceDsImp(ref.read(apiClientProvider));
});
