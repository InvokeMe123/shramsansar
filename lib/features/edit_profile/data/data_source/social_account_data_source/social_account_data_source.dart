import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shramsansar/core/api_client/api_client.dart';
import 'package:shramsansar/core/api_const/api_const.dart';
import 'package:shramsansar/features/edit_profile/data/models/social_accounts_model/add_social_accounts.dart';
import 'package:shramsansar/features/edit_profile/data/models/social_accounts_model/social_accounts_model.dart';

abstract class SocialAccountDataSource {
  Future<SocialAccountsModel> getSocialAccounts();
  Future<void> addSocialAccount(AddSocialAccountsModel model);
}

class SocialAccountDataSourceImpl implements SocialAccountDataSource {
  final ApiClient apiClient;

  SocialAccountDataSourceImpl({required this.apiClient});

  @override
  Future<SocialAccountsModel> getSocialAccounts() async {
    final accounts =
        await apiClient.request(path: ApiConst.GET_SOCIAL_NAME, type: 'get');

    return SocialAccountsModel.fromJson(accounts['data']);
  }

  @override
  Future<void> addSocialAccount(AddSocialAccountsModel model) async {
    await apiClient.request(
        path: ApiConst.ADD_SOCIAL, type: 'post', data: model.toJson());
  }
}

final socialAccountDataSourceProvider = Provider<SocialAccountDataSource>(
    (ref) =>
        SocialAccountDataSourceImpl(apiClient: ref.read(apiClientProvider)));
