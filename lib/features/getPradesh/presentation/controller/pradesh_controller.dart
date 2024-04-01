import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:shramsansar/features/getPradesh/data/models/pradeshModel.dart';

import 'package:shramsansar/features/getPradesh/data/repository/pradesh_repository.dart';

class PradeshController extends StateNotifier<AsyncValue<PradeshModel>> {
  final PradeshRepo pradeshRepo;
  PradeshController(this.pradeshRepo) : super(const AsyncValue.loading()) {
    getPradesh();
  }
  getPradesh() async {
    final result = await pradeshRepo.pradeshRepo();
    result.fold(
        (l) => state =
            AsyncValue.error(l.message, StackTrace.fromString(l.message)),
        (r) => state = AsyncValue.data(r));
  }
}

final pradeshControllerProvider = StateNotifierProvider.autoDispose<
    PradeshController, AsyncValue<PradeshModel>>((ref) {
  return PradeshController(ref.read(pradeshRepoProvider));
});
