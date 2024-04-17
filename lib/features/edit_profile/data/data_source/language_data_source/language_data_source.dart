import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shramsansar/core/api_client/api_client.dart';
import 'package:shramsansar/core/api_const/api_const.dart';
import 'package:shramsansar/features/edit_profile/data/models/language_model/language_model.dart';

abstract class LanguageDataSource {
  Future<void> addLanguage(LanguageModel language);
  Future<void> deleteLanguage(int id);
  Future<void> updateLanguage(LanguageModel language);
}

class LanguageDataSourceImpl implements LanguageDataSource {
  final ApiClient apiClient;

  LanguageDataSourceImpl({required this.apiClient});

  @override
  Future<void> addLanguage(LanguageModel language) async {
    await apiClient.request(
        path: ApiConst.POST_LAMGUAGE, type: 'post', data: language.toMap());
  }

  @override
  Future<void> deleteLanguage(int id) async {
    await apiClient.request(
        path: "${ApiConst.DELETE_LAMGUAGE}$id", type: 'get');
  }

  @override
  Future<void> updateLanguage(LanguageModel language) async {
    await apiClient.request(
        path: "${ApiConst.UPDATE_LAMGUAGE}${language.id}",
        type: 'post',
        data: language.toMap());
  }
}

final languageDataSourceProvider = Provider<LanguageDataSource>((ref) {
  return LanguageDataSourceImpl(apiClient: ref.read(apiClientProvider));
});
