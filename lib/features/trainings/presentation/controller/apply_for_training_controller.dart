import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shramsansar/features/trainings/data/repository/apply_for_training_repo.dart';

class ApplyForTrainingController extends StateNotifier<AsyncValue<String>> {
  ApplyForTrainingRepo applyForTrainingRepo;

  ApplyForTrainingController({required this.applyForTrainingRepo})
      : super(const AsyncValue.loading());

  void applyForTraining({required String trainingID}) async {
    final result =
        await applyForTrainingRepo.applyForTrainingRepo(trainingID: trainingID);

    debugPrint("Apply result: $result");

    result.fold((l) {
      state = AsyncValue.error(l.message, StackTrace.current);
    }, (r) {
      state = AsyncValue.data(r);
    });
  }
}

final applyForTrainingControllerProvider =
    StateNotifierProvider<ApplyForTrainingController, AsyncValue<String>>(
        (ref) {
  return ApplyForTrainingController(
      applyForTrainingRepo: ref.read(applyForTrainingRepoProvider));
});
