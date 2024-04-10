import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shramsansar/core/app_error/app_error.dart';
import 'package:shramsansar/features/training_center/data/model/training_centers_model.dart';
import 'package:shramsansar/features/training_center/data/repositories/training_center_repo.dart';

class TrainingCenterController
    extends StateNotifier<AsyncValue<TrainingCentersModel>> {
  final TrainingCenterRepo trainingCenterRepo;
  TrainingCenterController(this.trainingCenterRepo)
      : super(const AsyncValue.loading()) {
    getTrainingCenters(1);
  }

  getTrainingCenters(int pageIndex) async {
    final result = await trainingCenterRepo.getTrainingCenters(pageIndex);
    result.fold(
      (l) => state = AsyncValue.error(l.message, StackTrace.current),
      (r) => state = AsyncValue.data(r),
    );
  }
}

final trainingCenterControllerProvider = StateNotifierProvider<
    TrainingCenterController, AsyncValue<TrainingCentersModel>>((ref) {
  return TrainingCenterController(ref.read(trainingCenterRepoProvider));
});
