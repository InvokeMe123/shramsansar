import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shramsansar/core/api_client/api_client.dart';
import 'package:shramsansar/core/api_const/api_const.dart';
import 'package:shramsansar/features/edit_profile/data/models/about_me_update_model/about_me_model.dart';

abstract class AboutYouDs {
  Future<AboutMeModel> aboutYou();
}

class AboutYouDsImp implements AboutYouDs {
  final ApiClient apiClient;
  AboutYouDsImp(this.apiClient);

  @override
  Future<AboutMeModel> aboutYou() async {
    final result =
        await apiClient.request(path: ApiConst.VIEW_ABOUT_YOU, type: 'get');
    return AboutMeModel.fromJson(result);
  }
}

final aboutYouDsProvider = Provider<AboutYouDs>((ref) {
  return AboutYouDsImp(ref.read(apiClientProvider));
});
