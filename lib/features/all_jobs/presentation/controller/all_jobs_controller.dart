import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shramsansar/features/all_jobs/data/models/all_jobs_model.dart';
import 'package:shramsansar/features/all_jobs/data/repository/all_job_repo.dart';

class AllJobsController extends StateNotifier<AsyncValue<AllJobsModel>> {
  final AllJobsRepo allJobsRepo;

  AllJobsController(this.allJobsRepo) : super(AsyncValue.loading());

  Future<void> getAllJobs(int pageId, int? muniId, int? categoryId,
      int? pradeshId, int? districtId) async {
    final result = await allJobsRepo.allJobsRepo(
        pageId, muniId, categoryId, pradeshId, districtId);
    result.fold(
        (l) => state =
            AsyncValue.error(l.toString(), StackTrace.fromString(l.toString())),
        (r) => state = AsyncValue.data(r));
  }

  Future<void> addAllJobs() async {
    final result = await allJobsRepo.addAllJobs();
    AllJobsModel? allJobsModel;
    List<Data> viewJobsdata = [];
    // viewJobsdata.addAll(allJobsModel!.data!);
    result.fold((error) {
      state = AsyncValue.error(
        error.message,
        StackTrace.fromString(error.toString()),
      );
    }, (data) {
      if (data.data != null && data.data!.isNotEmpty) {
        viewJobsdata.addAll(data.data!);
        state = AsyncValue.data(data);
      } else {
        // Set the state to indicate empty data
        state = AsyncValue.error(
          'Invalid',
          StackTrace.fromString('Invalid'),
        );
      }
    });
  }
}

final allJobsControllerProvider =
    StateNotifierProvider<AllJobsController, AsyncValue<AllJobsModel>>((ref) {
  return AllJobsController(ref.watch(allJobsRepoProvider));
});
