import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shramsansar/features/edit_profile/data/models/education_model/education_model.dart';
import 'package:shramsansar/features/edit_profile/data/repositories/education_repo/education_repo.dart';

class EducationController extends StateNotifier<AsyncValue<EducationModel>> {
  final EducationRepo educationRepo;
  EducationController(this.educationRepo) : super(const AsyncValue.loading()) {
    getEducationDropDown();
  }

  getEducationDropDown() async {
    final result = await educationRepo.educationDropRepo();
    result.fold(
        (l) => state = AsyncError(l.message, StackTrace.fromString(l.message)),
        (r) => state = AsyncValue.data(r));
  }

 
}

final educationControllerProvider =
    StateNotifierProvider<EducationController, AsyncValue<EducationModel>>(
        (ref) {
  return EducationController(ref.read(educationRepoProvider));
});
