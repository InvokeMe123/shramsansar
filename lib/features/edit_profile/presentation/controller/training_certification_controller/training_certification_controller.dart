import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shramsansar/features/edit_profile/data/models/experience_model/experience_model.dart';
import 'package:shramsansar/features/edit_profile/data/repositories/experience_repo/experience_repo.dart';
import 'package:shramsansar/features/edit_profile/data/repositories/training_certifcation_repo/training_certifcation_repo.dart';

class TrainingCertificationController extends StateNotifier<AsyncValue<void>> {
  final TrainingCertificationRepo trainingCertificationRepo;
  TrainingCertificationController(this.trainingCertificationRepo)
      : super(const AsyncValue.loading());

  Future<bool> addTraining(FormData formData) async {
    bool flag = false;
    final result =
        await trainingCertificationRepo.trainingCertificationRepo(formData);
    result.fold((l) {
      state = AsyncValue.error(l.message, StackTrace.fromString(l.message));
    }, (r) {
      flag = true;
    });
    return flag;
  }

  Future<bool> deleteExperienceC(int id) async {
    bool flag = false;
    final result =
        await trainingCertificationRepo.deletetrainingCertificationRepo(id);
    result.fold((l) {
      state = AsyncValue.error(l.message, StackTrace.fromString(l.message));
    }, (r) {
      flag = true;
    });
    return flag;
  }

  Future<bool> editTraininCertification(int id, FormData formData) async {
    bool flag = false;
    final result = await trainingCertificationRepo
        .editTrainingCertificationRepo(id, formData);
    result.fold((l) {
      state = AsyncValue.error(l.message, StackTrace.fromString(l.message));
    }, (r) {
      flag = true;
    });
    return flag;
  }
}

final trainingCertificationControllerProvider =
    StateNotifierProvider<TrainingCertificationController, AsyncValue<void>>(
        (ref) {
  return TrainingCertificationController(
      ref.read(trainingCertificationRepoProvider));
});
