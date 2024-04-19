import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shramsansar/features/jobs/data/models/job_category_model.dart';
import 'package:shramsansar/features/jobs/data/repository/job_category_repo.dart';

class JobCategoryController
    extends StateNotifier<AsyncValue<JobCategoryModel>> {
  final JobCategoryRepo jobCategoryRepo;
  JobCategoryController(this.jobCategoryRepo)
      : super(const AsyncValue.loading()) {
    getJobCategory();
  }
  getJobCategory() async {
    final result = await jobCategoryRepo.getJobCatergory();
    result.fold(
        (l) => state =
            AsyncValue.error(l.message, StackTrace.fromString(l.message)),
        (r) => state = AsyncValue.data(r));
  }
}

final jobCategoryControllerProvider =
    StateNotifierProvider<JobCategoryController, AsyncValue<JobCategoryModel>>(
        (ref) {
  return JobCategoryController(ref.read(jobcategoryRepoProvider));
});
