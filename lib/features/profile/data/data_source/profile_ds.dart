import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shramsansar/core/api_client/api_client.dart';
import 'package:shramsansar/core/api_const/api_const.dart';
import 'package:shramsansar/features/edit_profile/data/models/education_model/education_model_req.dart';
import 'package:shramsansar/features/profile/data/model/profile_model.dart';

abstract class ProfileDataSource {
  Future<MyProfileModel> getMyProfile();
  Future<void> updateAboutMe(Map<String, String> data);
  Future<void> addEducation(EducationReqModel data);
  Future<void> deleteEducation(int educationID);
}

class ProfileDataSourceImp implements ProfileDataSource {
  final ApiClient apiClient;
  ProfileDataSourceImp(this.apiClient);
  @override
  Future<MyProfileModel> getMyProfile() async {
    final result =
        await apiClient.request(path: ApiConst.MY_PROFILE, type: 'get');
    //log('profile DS:${result['data']}');
    return MyProfileModel.fromJson(result['data']);
  }

  @override
  Future<void> updateAboutMe(Map<String, String> data) async {
    await apiClient.request(
        type: 'post', path: ApiConst.POST_ABOUT_ME, data: data);
  }

  @override
  Future<void> addEducation(EducationReqModel data) async {
    await apiClient.request(
        type: 'post', path: ApiConst.POST_EDUCATION, data: data.toMap());
  }

  @override
  Future<void> deleteEducation(int educationID) async {
    await apiClient.request(
        type: "get", path: "${ApiConst.DELETE_EDUCATION}/$educationID");
  }
}

final profileDataSourceProvider = Provider<ProfileDataSource>((ref) {
  return ProfileDataSourceImp(ref.read(apiClientProvider));
});
