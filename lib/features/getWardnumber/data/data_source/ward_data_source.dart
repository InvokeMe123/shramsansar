import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shramsansar/core/api_client/api_client.dart';
import 'package:shramsansar/core/api_const/api_const.dart';
import 'package:shramsansar/features/getWardnumber/data/models/ward_model.dart';

abstract class WardDataSource {
  Future<WardModel> wardDS();
}

class WardDataSourceImp implements WardDataSource {
  final ApiClient apiClient;
  WardDataSourceImp(this.apiClient);

  @override
  Future<WardModel> wardDS() async {
    final result = await apiClient.request(path: ApiConst.WARD);
    return WardModel.fromJson(result['data']);
  }
}

final wardDataSourceProvider = Provider<WardDataSource>((ref) {
  return WardDataSourceImp(ref.read(apiClientProvider));
});
