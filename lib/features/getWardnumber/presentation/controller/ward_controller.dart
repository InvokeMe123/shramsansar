import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shramsansar/features/getWardnumber/data/models/ward_model.dart';
import 'package:shramsansar/features/getWardnumber/data/repository/ward_repository.dart';

class WardController extends StateNotifier<AsyncValue<WardModel>> {
  final WardRepo wardRepo;
  WardController(this.wardRepo) : super(const AsyncValue.loading()) {
    getWard();
  }

  getWard() async {
    final result = await wardRepo.wardRepo();
    result.fold(
        (l) => state = AsyncError(l.message, StackTrace.fromString(l.message)),
        (r) => state = AsyncValue.data(r));
  }
}

final wardControllerProvider =
    StateNotifierProvider<WardController, AsyncValue<WardModel>>((ref) {
  return WardController(ref.read(wardRepoProvider));
});
