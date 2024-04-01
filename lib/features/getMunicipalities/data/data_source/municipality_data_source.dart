import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shramsansar/core/api_client/api_client.dart';
import 'package:shramsansar/core/api_const/api_const.dart';
import 'package:shramsansar/features/getMunicipalities/data/models/municipality_model.dart';

abstract class MuniDataSource {
  Future<MunicipalityModel> muniDS();
}

class MuniDataSourceImp implements MuniDataSource {
  final ApiClient apiClient;
  MuniDataSourceImp(this.apiClient);

  @override
  Future<MunicipalityModel> muniDS() async {
    final result =
        await apiClient.request(path: ApiConst.MUNICIPALITIES, type: 'get');

    return MunicipalityModel.fromJson(result['data']);
  }
}

final muniDSProvider = Provider<MuniDataSource>((ref) {
  return MuniDataSourceImp(ref.read(apiClientProvider));
});
