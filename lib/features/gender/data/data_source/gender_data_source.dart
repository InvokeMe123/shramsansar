import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shramsansar/core/api_client/api_client.dart';
import 'package:shramsansar/core/api_const/api_const.dart';
import 'package:shramsansar/features/gender/data/models/gender_model.dart';

abstract class GenderDataSource {
  Future<GenderModel> genderDS();
}

class GenderDataSourceImp implements GenderDataSource {
  final ApiClient apiClient;
  GenderDataSourceImp(this.apiClient);
  @override
  Future<GenderModel> genderDS() async {
    final result = await apiClient.request(path: ApiConst.GENDER, type: 'get');

    return GenderModel.fromJson(result['data']);
  }
}

final genderDataSourceProvider = Provider<GenderDataSource>((ref) {
  return GenderDataSourceImp(ref.read(apiClientProvider));
});
