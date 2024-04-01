import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shramsansar/core/api_client/api_client.dart';
import 'package:shramsansar/core/api_const/api_const.dart';
import 'package:shramsansar/features/caste/data/models/caste_model.dart';

abstract class CasteDataSource {
  Future<CasteModel> casteDS();
}

class CasteDataSourceImp implements CasteDataSource {
  final ApiClient apiClient;
  CasteDataSourceImp(this.apiClient);

  @override
  Future<CasteModel> casteDS() async {
    final result = await apiClient.request(path: ApiConst.GET_CAST);

    return CasteModel.fromJson(result['data']);
  }
}

final casteDataSourceProvider = Provider<CasteDataSource>((ref) {
  return CasteDataSourceImp(ref.read(apiClientProvider));
});
