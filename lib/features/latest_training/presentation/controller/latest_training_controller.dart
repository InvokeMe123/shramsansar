import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shramsansar/features/latest_training/data/repository/latest_training_repo.dart';
import 'package:shramsansar/features/trainings/data/models/training_model/training_model.dart';

class LatestTrainingController
    extends StateNotifier<AsyncValue<TrainingModel>> {
  final LatestTrainingRepo latestTrainingRepo;
  LatestTrainingController(this.latestTrainingRepo)
      : super(const AsyncValue.loading()) {
    getLatestTraining();
  }

  Future<void> getLatestTraining() async {
    final result = await latestTrainingRepo.getLatestTrainingRepo();

    result.fold((l) => state = AsyncValue.error(l, StackTrace.current),
        (r) => state = AsyncValue.data(r));
  }
}

final latestTrainingControllerProvider =
    StateNotifierProvider<LatestTrainingController, AsyncValue<TrainingModel>>(
        (ref) {
  return LatestTrainingController(ref.read(latestTrainingRepoProvider));
});
