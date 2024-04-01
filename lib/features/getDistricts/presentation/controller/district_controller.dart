import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shramsansar/features/getDistricts/data/models/district_model.dart';
import 'package:shramsansar/features/getDistricts/data/repository/district_repository.dart';

class DistrictController extends StateNotifier<AsyncValue<DistrictModel>> {
  final DistrictRepo districtRepo;
  DistrictController(this.districtRepo) : super(const AsyncValue.loading()) {
    getDistricts();
  }
  getDistricts() async {
    final result = await districtRepo.getDistrictRepo();
    result.fold(
        (l) => state =
            AsyncValue.error(l.message, StackTrace.fromString(l.message)),
        (r) => state = AsyncValue.data(r));
  }
}

final districtControllerProvider = StateNotifierProvider.autoDispose<
    DistrictController, AsyncValue<DistrictModel>>((ref) {
  return DistrictController(ref.read(districtRepoProvider));
});
