import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shramsansar/core/app_error/app_error.dart';
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
    log(result.toString());
    result.fold(
        (l) => state =
            AsyncValue.error(l.message, StackTrace.fromString(l.message)),
        (r) => state =  AsyncValue.data(r));
  }
}

final profileControllerProvider =
    StateNotifierProvider.autoDispose<ProfileController, AsyncValue<MyProfileModel>>((ref) {
  return ProfileController(ref.read(profileRepoProvider));
});
