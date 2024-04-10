import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shramsansar/features/edit_profile/data/models/about_me_update_model/about_me_model.dart';
import 'package:shramsansar/features/edit_profile/data/repositories/about_me/about_you_repo.dart';

class AboutYouController extends StateNotifier<AsyncValue<AboutMeModel>> {
  final AboutYouRepo aboutYouRepo;
  AboutYouController(this.aboutYouRepo) : super(AsyncValue.loading()) {
    aboutYou();
  }
  aboutYou() async {
    final result = await aboutYouRepo.aboutYouRepo();
    result.fold(
        (l) => state =
            AsyncValue.error(l.message, StackTrace.fromString(l.message)),
        (r) => state = AsyncValue.data(r));
  }
}

final aboutYouControllerProvider = StateNotifierProvider.autoDispose<
    AboutYouController, AsyncValue<AboutMeModel>>((ref) {
  return AboutYouController(ref.read(aboutYouRepoProvider));
});
