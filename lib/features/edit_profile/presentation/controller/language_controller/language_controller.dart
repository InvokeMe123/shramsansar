import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shramsansar/features/edit_profile/data/models/language_model/language_model.dart';
import 'package:shramsansar/features/edit_profile/data/repositories/language_repo/language_repo.dart';

class LanguageController extends StateNotifier<AsyncValue<LanguageModel>> {
  final LanguageRepo languageRepo;
  LanguageController(this.languageRepo) : super(AsyncValue.loading());

  Future<bool> addLanguage(LanguageModel language) async {
    final result = await languageRepo.addLanguage(language);
    bool flag = false;
    result.fold((l) {}, (r) => flag = true);

    return flag;
  }

  Future<bool> deleteLanguage(int id) async {
    final result = await languageRepo.deleteLanguage(id);
    bool flag = false;
    result.fold((l) {}, (r) => flag = true);

    return flag;
  }

  Future<bool> updateLanguage(LanguageModel language) async {
    final result = await languageRepo.updateLanguage(language);
    bool flag = false;
    result.fold((l) {}, (r) => flag = true);

    return flag;
  }
}

final languageControllerProvider =
    StateNotifierProvider<LanguageController, AsyncValue<LanguageModel>>((ref) {
  final languageRepo = ref.read(languageRepoProvider);
  return LanguageController(languageRepo);
});
