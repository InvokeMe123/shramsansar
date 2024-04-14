import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shramsansar/core/api_client/api_client.dart';
import 'package:shramsansar/core/api_const/api_const.dart';
import 'package:shramsansar/core/dbclient.dart';
import 'package:shramsansar/features/edit_profile/data/models/about_me_update_model/about_me_update_req_model.dart';
import 'package:shramsansar/features/edit_profile/data/models/about_me_update_model/about_me_update_res_model.dart';

abstract class AboutMeUpdateDs {
  Future<AboutMeUpdateResModel> updateAboutMeDs(
      AboutMeUpdateReqModel aboutMeUpdateReqModel);
}

class AboutMeUpdateDsImp implements AboutMeUpdateDs {
  final ApiClient apiClient;
  AboutMeUpdateDsImp(this.apiClient);

  @override
  Future<AboutMeUpdateResModel> updateAboutMeDs(
      AboutMeUpdateReqModel aboutMeUpdateReqModel) async {
    String token = await DbClient().getData(dbKey: 'token');
    final result = await apiClient.request(
        path: ApiConst.POST_ABOUT_ME,
        type: 'put',
        data: aboutMeUpdateReqModel.toMap(),
        token: 'Bearer $token');
    return AboutMeUpdateResModel.fromJson(result);
  }
}

final aboutMeUpdateDsProvider = Provider<AboutMeUpdateDs>((ref) {
  return AboutMeUpdateDsImp(ref.read(apiClientProvider));
});
