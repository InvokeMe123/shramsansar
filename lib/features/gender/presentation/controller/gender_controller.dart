
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shramsansar/features/gender/data/models/gender_model.dart';
import 'package:shramsansar/features/gender/data/repository/gender_repo.dart';

class GenderController extends StateNotifier<AsyncValue<GenderModel>> {
  final GenderRepo genderRepo;
  GenderController(this.genderRepo) : super(const AsyncValue.loading()) {
    getGender();
  }
  getGender() async {
    final result = await genderRepo.genderRepo();
    return result.fold(
        (l) => state =
            AsyncValue.error(l.message, StackTrace.fromString(l.message)),
        (r) => state = AsyncValue.data(r));
  }
}

final genderControllerProvider = StateNotifierProvider.autoDispose<GenderController, AsyncValue<GenderModel>>((ref) {
  return GenderController(ref.read(genderRepoProvider));
});
