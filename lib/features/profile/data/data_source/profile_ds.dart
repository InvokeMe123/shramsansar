import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shramsansar/core/api_client/api_client.dart';
import 'package:shramsansar/core/api_const/api_const.dart';
import 'package:shramsansar/features/profile/data/model/profile_model.dart';

abstract class ProfileDataSource {
  Future<MyProfileModel> getMyProfile();
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
}

final profileDataSourceProvider = Provider<ProfileDataSource>((ref) {
  return ProfileDataSourceImp(ref.read(apiClientProvider));
});
