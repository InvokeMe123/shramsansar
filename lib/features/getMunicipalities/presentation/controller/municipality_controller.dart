import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shramsansar/features/getMunicipalities/data/models/municipality_model.dart';
import 'package:shramsansar/features/getMunicipalities/data/repository/municipality_repository.dart';

class MuniController extends StateNotifier<AsyncValue<MunicipalityModel>> {
  final MuniRepo muniRepo;
  MuniController(this.muniRepo) : super(const AsyncLoading()) {
    getMuni();
  }

  getMuni() async {
    final result = await muniRepo.muniRepo();
    result.fold(
        (l) => state =
            AsyncValue.error(l.message, StackTrace.fromString(l.message)),
        (r) => state = AsyncValue.data(r));
  }
}

final muniControllerProvider = StateNotifierProvider.autoDispose<MuniController,
    AsyncValue<MunicipalityModel>>((ref) {
  return MuniController(ref.read(muniRepoProvider));
});
