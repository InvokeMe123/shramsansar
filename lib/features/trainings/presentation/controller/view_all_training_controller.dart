import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shramsansar/features/trainings/data/models/training_model/training_model.dart';
import 'package:shramsansar/features/trainings/data/repository/view_all_training_repo.dart';

class ViewAllTrainingController
    extends StateNotifier<AsyncValue<TrainingModel>> {
  final ViewAllTrainingRepository viewAllTrainingRepository;
  final int pageIndex;

  ViewAllTrainingController(
      {required this.viewAllTrainingRepository, required this.pageIndex})
      : super(const AsyncValue.loading()) {
    getAllTrainingDetails();
  }

  getAllTrainingDetails() async {
    final result =
        await viewAllTrainingRepository.getAllTrainingRepo(pageIndex);
    result.fold((l) {
      state = AsyncValue.error(l.message, StackTrace.current);
    }, (r) {
      // we have data
      state = AsyncValue.data(r);
    });
  }

  searchTrainingDetails(
      {required String muniID, required String categoryID}) async {
    final result = await viewAllTrainingRepository.searchTrainingRepo(
        muniID: muniID, categoryID: categoryID);
    result.fold((l) {
      state = AsyncValue.error(l.message, StackTrace.current);
    }, (r) {
      // we have data
      state = AsyncValue.data(r);
    });
  }
}

final viewAllTrainingControllerProvider = StateNotifierProvider.family<
    ViewAllTrainingController,
    AsyncValue<TrainingModel>,
    int>((ref, pageIndex) {
  return ViewAllTrainingController(
      viewAllTrainingRepository: ref.read(viewAllTrainingRepositoryProvider),
      pageIndex: pageIndex);
});
