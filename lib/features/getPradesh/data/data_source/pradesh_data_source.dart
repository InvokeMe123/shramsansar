import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shramsansar/core/api_client/api_client.dart';
import 'package:shramsansar/core/api_const/api_const.dart';
import 'package:shramsansar/features/getPradesh/data/models/pradeshModel.dart';

abstract class PradeshDataSource {
  Future<PradeshModel> pradeshDs();
}

class PradeshDataSourceImp implements PradeshDataSource {
  final ApiClient apiClient;
  PradeshDataSourceImp(this.apiClient);

  @override
  Future<PradeshModel> pradeshDs() async {
    final result = await apiClient.request(path: ApiConst.PRODESH);

    return PradeshModel.fromJson(result['data']);
  }
}

final pradeshDataSourceProvider = Provider<PradeshDataSource>((ref) {
  return PradeshDataSourceImp(ref.read(apiClientProvider));
});
