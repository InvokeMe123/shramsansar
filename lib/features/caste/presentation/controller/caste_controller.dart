import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shramsansar/features/caste/data/models/caste_model.dart';
import 'package:shramsansar/features/caste/data/repository/caste_repository.dart';

class CasteController extends StateNotifier<AsyncValue<CasteModel>> {
  final CasteRepo casteRepo;
  CasteController(this.casteRepo) : super(const AsyncValue.loading()) {
    getCaste();
  }
  getCaste() async {
    final result = await casteRepo.casteRepo();
    result.fold(
        (l) => state =
            AsyncValue.error(l.message, StackTrace.fromString(l.message)),
        (r) => state = AsyncValue.data(r));
  }
}

final casteControllerProvicer =
    StateNotifierProvider.autoDispose<CasteController, AsyncValue<CasteModel>>(
        (ref) {
  return CasteController(ref.read(casteRepoProvider));
});
