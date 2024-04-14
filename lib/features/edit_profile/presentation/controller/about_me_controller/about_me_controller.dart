import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shramsansar/features/edit_profile/data/models/about_me_update_model/about_me_update_req_model.dart';
import 'package:shramsansar/features/edit_profile/data/models/about_me_update_model/about_me_update_res_model.dart';
import 'package:shramsansar/features/edit_profile/data/repositories/about_me/about_me_update_repo.dart';

class AboutMeUpdateController
    extends StateNotifier<AsyncValue<AboutMeUpdateResModel>> {
  final AboutMeUpdateRepo aboutMeUpdateRepo;
  AboutMeUpdateController(this.aboutMeUpdateRepo) : super(AsyncValue.loading());
  getAboutMe(AboutMeUpdateReqModel aboutMeUpdateReqModel) async {
    final result =
        await aboutMeUpdateRepo.aboutMeUpdateRepo(aboutMeUpdateReqModel);
    result.fold(
        (l) => state =
            AsyncValue.error(l.message, StackTrace.fromString(l.message)),
        (r) => state = AsyncValue.data(r));
  }
}

final aboutMeUpdateControllerProvider = StateNotifierProvider<
    AboutMeUpdateController, AsyncValue<AboutMeUpdateResModel>>((ref) {
  return AboutMeUpdateController(ref.read(aboutMeUpdateRepoProvider));
});
