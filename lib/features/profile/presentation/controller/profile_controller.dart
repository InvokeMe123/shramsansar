import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shramsansar/features/edit_profile/data/models/education_model/education_model.dart';
import 'package:shramsansar/features/edit_profile/data/models/education_model/education_model_req.dart';

import 'package:shramsansar/features/profile/data/model/profile_model.dart';
import 'package:shramsansar/features/profile/data/repositories/profile_repo.dart';

class ProfileController extends StateNotifier<AsyncValue<MyProfileModel>> {
  final ProfileRepo profileRepo;
  ProfileController(this.profileRepo) : super(AsyncValue.loading()) {
    getMyProfile();
  }
  Future getMyProfile() async {
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

  /// Returns true if added successfully, false if not
  Future<bool> addEducation(
      {required EducationReqModel educationReqModel}) async {
    final result = await profileRepo.addEducation(educationReqModel);
    bool flag = false;

    result.fold((l) {
      state = AsyncValue.error(l.message, StackTrace.fromString(l.message));
    }, (r) {
      flag = true;
    });

    return flag;
  }

  /// updating the education
  Future<bool> updateEducation(
      {required EducationReqModel educationReqModel, required int id}) async {
    final result = await profileRepo.updateEducation(id, educationReqModel);
    bool flag = false;

    result.fold((l) {
      state = AsyncValue.error(l.message, StackTrace.fromString(l.message));
    }, (r) {
      flag = true;
    });
    return flag;
  }

  // Delete education
  Future<bool> deleteEducation(
      {required MyProfileModel profileModel, required int id}) async {
    final result = await profileRepo.deleteEducation(id);
    bool flag = false;

    result.fold((l) {
      state = AsyncValue.error(l.message, StackTrace.fromString(l.message));
    }, (r) {
      final model = profileModel.copyWith(
          educations: profileModel.educations!
              .where((element) => element.id != id)
              .toList());
      state = AsyncValue.data(model);
      flag = true;
    });
    return flag;
  }
}

final profileControllerProvider = StateNotifierProvider.autoDispose<
    ProfileController, AsyncValue<MyProfileModel>>((ref) {
  return ProfileController(ref.read(profileRepoProvider));
});
