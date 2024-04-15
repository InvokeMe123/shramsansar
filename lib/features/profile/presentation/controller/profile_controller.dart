import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:shramsansar/features/profile/data/model/profile_model.dart';
import 'package:shramsansar/features/profile/data/repositories/profile_repo.dart';

class ProfileController extends StateNotifier<AsyncValue<MyProfileModel>> {
  final ProfileRepo profileRepo;
  ProfileController(this.profileRepo) : super(AsyncValue.loading()) {
    getMyProfile();
  }
  getMyProfile() async {
    print('profile controller');
    final result = await profileRepo.profileRepo();
    //log(result.toString());
    result.fold(
        (l) => state =
            AsyncValue.error(l.message, StackTrace.fromString(l.message)),
        (r) => state = AsyncValue.data(r));
  }

  updateAboutMe(
      {required MyProfileModel model,
      required Map<String, String> data}) async {
    final result = await profileRepo.updateAboutMe(data);

    result.fold((l) {
      state = AsyncValue.error(l.message, StackTrace.fromString(l.message));
    }, (r) {
      final profileModel = model.copyWith(
          aboutYourself:
              AboutYourself().copyWith(description: data["about_me"]));
      state = AsyncValue.data(profileModel);
    });
  }
}

final profileControllerProvider = StateNotifierProvider.autoDispose<
    ProfileController, AsyncValue<MyProfileModel>>((ref) {
  return ProfileController(ref.read(profileRepoProvider));
});
