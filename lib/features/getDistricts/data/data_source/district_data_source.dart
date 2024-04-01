import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shramsansar/core/api_client/api_client.dart';
import 'package:shramsansar/core/api_const/api_const.dart';
import 'package:shramsansar/features/getDistricts/data/models/district_model.dart';

abstract class DistrictDataSource {
  Future<DistrictModel> getDistrictDS();
}

class DistrictDataSourceImp implements DistrictDataSource {
  final ApiClient apiClient;
  DistrictDataSourceImp(this.apiClient);

  @override
  Future<DistrictModel> getDistrictDS() async {
    final result =
        await apiClient.request(path: ApiConst.DISTRICTS, type: 'get');
    return DistrictModel.fromJson(result['data']);
  }
}

final districtDataSourceProvider = Provider<DistrictDataSource>((ref) {
  return DistrictDataSourceImp(ref.read(apiClientProvider));
});
