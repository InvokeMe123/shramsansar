import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shramsansar/features/edit_profile/data/models/experience_model/experience_model.dart';
import 'package:shramsansar/features/edit_profile/data/repositories/experience_repo/experience_repo.dart';

class ExperienceController extends StateNotifier<AsyncValue<void>> {
  final ExperienceRepo experienceRepo;
  ExperienceController(this.experienceRepo) : super(const AsyncValue.loading());

  Future<bool> addExperience(FormData formData) async {
    bool flag = false;
    final result = await experienceRepo.experienceRepo(formData);
    result.fold((l) {
      state = AsyncValue.error(l.message, StackTrace.fromString(l.message));
    }, (r) {
      flag = true;
    });
    return flag;
  }

  Future<bool> deleteExperienceC(int id) async{
     bool flag = false;
    final result = await experienceRepo.deleteExperinceRepo(id);
    result.fold((l) {
      state = AsyncValue.error(l.message, StackTrace.fromString(l.message));
    }, (r) {
      flag = true;
    });
    return flag;

  }
  Future<bool> editExperienceC(int id,FormData formData) async{
     bool flag = false;
    final result = await experienceRepo.editExperinceRepo(id, formData);
    result.fold((l) {
      state = AsyncValue.error(l.message, StackTrace.fromString(l.message));
    }, (r) {
      flag = true;
    });
    return flag;

  }
}

final experienceControllerProvider =
    StateNotifierProvider<ExperienceController, AsyncValue<void>>((ref) {
  return ExperienceController(ref.read(experienceRepoProvider));
});
