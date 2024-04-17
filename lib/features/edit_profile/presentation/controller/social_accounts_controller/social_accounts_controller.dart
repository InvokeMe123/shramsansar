import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shramsansar/features/edit_profile/data/models/social_accounts_model/add_social_accounts.dart';
import 'package:shramsansar/features/edit_profile/data/models/social_accounts_model/social_accounts_model.dart';
import 'package:shramsansar/features/edit_profile/data/repositories/social_accounts_repo/social_accounts_repo.dart';

class SocialAccountsController
    extends StateNotifier<AsyncValue<SocialAccountsModel>> {
  final SocialAccountsRepo socialAccountsRepo;
  SocialAccountsController(this.socialAccountsRepo)
      : super(const AsyncValue.loading()) {
    getSocialAccounts();
  }

  Future getSocialAccounts() async {
    final result = await socialAccountsRepo.getSocialAccounts();
    result.fold(
        (l) => state =
            AsyncValue.error(l.message, StackTrace.fromString(l.message)),
        (r) => state = AsyncValue.data(r));
  }

  Future<bool> addSocialAccounts(AddSocialAccountsModel model) async {
    final result = await socialAccountsRepo.addSocialAccount(model);
    bool flag = false;

    result.fold((l) {
      state = AsyncValue.error(l.message, StackTrace.fromString(l.message));
    }, (r) {
      flag = true;
    });

    return flag;
  }

  Future<bool> deleteSocialAccount(int id) async {
    final result = await socialAccountsRepo.deleteSocialAccount(id);
    bool flag = false;

    result.fold((l) {
      state = AsyncValue.error(l.message, StackTrace.fromString(l.message));
    }, (r) {
      flag = true;
    });

    return flag;
  }
}

final socialAccountsControllerProvider = StateNotifierProvider<
    SocialAccountsController, AsyncValue<SocialAccountsModel>>(
  (ref) => SocialAccountsController(ref.read(socialAccountsRepoProvider)),
);
