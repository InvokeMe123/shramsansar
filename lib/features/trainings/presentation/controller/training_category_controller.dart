import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shramsansar/features/trainings/data/models/training_category_model/training_category_model.dart';
import 'package:shramsansar/features/trainings/data/repository/training_category_repo.dart';

class TrainingCategoryController
    extends StateNotifier<AsyncValue<TrainingCategoryModel>> {
  final TrainingCategoryRepo repo;
  TrainingCategoryController(this.repo) : super(const AsyncValue.loading()) {
    getJobCategory();
  }
  getJobCategory() async {
    final result = await repo.fetch();
    result.fold(
        (l) => state =
            AsyncValue.error(l.message, StackTrace.fromString(l.message)),
        (r) => state = AsyncValue.data(r));
  }
}

final trainingCategoryControllerProvider = StateNotifierProvider<
    TrainingCategoryController, AsyncValue<TrainingCategoryModel>>((ref) {
  return TrainingCategoryController(ref.read(trainingCategoryRepoProvider));
});
