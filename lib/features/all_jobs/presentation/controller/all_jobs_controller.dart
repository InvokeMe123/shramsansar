import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shramsansar/features/all_jobs/data/models/all_jobs_model.dart';
import 'package:shramsansar/features/all_jobs/data/repository/all_job_repo.dart';

class AllJobsController extends StateNotifier<AsyncValue<AllJobsModel>> {
  final AllJobsRepo allJobsRepo;
  final int pageIndex;

  AllJobsController({required this.allJobsRepo, required this.pageIndex})
      : super(const AsyncValue.loading()) {
    getAllJobsDetails();
  }

  Future<void> getAllJobsDetails() async {
    final result = await allJobsRepo.getAllJobRepo(pageIndex);
    result.fold(
        (l) => state =
            AsyncValue.error(l.toString(), StackTrace.fromString(l.toString())),
        (r) => state = AsyncValue.data(r));
  }

  Future<void> searchJobsDetail(
      {required String muniID, required String categoryID}) async {
    final result =
        await allJobsRepo.searchJobRepo(muniID: muniID, categoryID: categoryID);

    result.fold(
        (l) => state =
            AsyncValue.error(l.message, StackTrace.fromString(l.message)),
        (r) => state = AsyncValue.data(r));
  }
}

final allJobsControllerProvider = StateNotifierProvider.family<
    AllJobsController, AsyncValue<AllJobsModel>, int>((ref, pageIndex) {
  return AllJobsController(
      allJobsRepo: ref.read(allJobsRepoProvider), pageIndex: pageIndex);
});
