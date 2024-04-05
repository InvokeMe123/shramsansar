import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shramsansar/features/all_jobs/data/models/latest_job_model.dart';
import 'package:shramsansar/features/all_jobs/data/repository/latest_job_repo.dart';

class LatestJobController extends StateNotifier<AsyncValue<LatestJobModel>> {
  final LatestJobRepo latestJobRepo;
  LatestJobController(this.latestJobRepo) : super(AsyncValue.loading()) {
    getLatestJobs();
  }

  Future<void> getLatestJobs() async {
    final result = await latestJobRepo.getLatestJobRepo();
    result.fold(
        (l) => state =
            AsyncValue.error(l.toString(), StackTrace.fromString(l.toString())),
        (r) => state = AsyncValue.data(r));
  }
}

final latestJobControllerProvider =
    StateNotifierProvider<LatestJobController, AsyncValue<LatestJobModel>>(
        (ref) {
  return LatestJobController(ref.read(latestJobRepoProvider));
});
