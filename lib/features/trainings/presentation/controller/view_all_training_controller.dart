import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shramsansar/core/app_error/app_error.dart';
import 'package:shramsansar/features/trainings/data/models/training_model/training_model.dart';
import 'package:shramsansar/features/trainings/data/repository/view_all_training_repo.dart';

class ViewAllTrainingController
    extends StateNotifier<AsyncValue<TrainingModel>> {
  final ViewAllTrainingRepository viewAllTrainingRepository;

  ViewAllTrainingController({required this.viewAllTrainingRepository})
      : super(const AsyncValue.loading()) {
    getAllTrainingDetails();
  }

  getAllTrainingDetails() async {
    final result = await viewAllTrainingRepository.getAllTrainingRepo();
    result.fold((l) {
      state = AsyncValue.error(l.message, StackTrace.current);
    }, (r) {
      // we have data
      state = AsyncValue.data(r);
    });
  }
}

final viewAllTrainingControllerProvider =
    StateNotifierProvider<ViewAllTrainingController, AsyncValue<TrainingModel>>(
        (ref) {
  return ViewAllTrainingController(
      viewAllTrainingRepository: ref.read(viewAllTrainingRepositoryProvider));
});
