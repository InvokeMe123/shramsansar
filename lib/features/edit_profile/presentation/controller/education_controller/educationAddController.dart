import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shramsansar/features/edit_profile/data/models/education_model/education_model_req.dart';
import 'package:shramsansar/features/edit_profile/data/models/education_model/education_model_res.dart';
import 'package:shramsansar/features/edit_profile/data/repositories/education_repo/education_repo.dart';
import 'package:shramsansar/features/edit_profile/presentation/controller/education_controller/education_controller.dart';

class EducationAddController
    extends StateNotifier<AsyncValue<EducationResModel>> {
  final EducationRepo educationRepo;
  EducationAddController(this.educationRepo) : super(AsyncValue.loading());
  addEducation(EducationReqModel educationReqModel) async {
    final result = await educationRepo.educationAddRepo(educationReqModel);
    result.fold(
        (l) => state = AsyncError(l.message, StackTrace.fromString(l.message)),
        (r) => state = AsyncValue.data(r));
  }
  deleteEducationn(int id) async{
    final result = await educationRepo.educationDeleteRepo(id);
    result.fold(
        (l) => state = AsyncError(l.message, StackTrace.fromString(l.message)),
        (r) => state = AsyncValue.data(r));

  }
}

final educationAddControllerProvider = StateNotifierProvider<
    EducationAddController, AsyncValue<EducationResModel>>((ref) {
  return EducationAddController(ref.read(educationRepoProvider));
});