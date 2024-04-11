import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shramsansar/core/api_client/api_client.dart';
import 'package:shramsansar/core/api_const/api_const.dart';
import 'package:shramsansar/features/edit_profile/data/models/education_model/education_model.dart';

abstract class EducationDs {
  Future<EducationModel> educationDropDs();
}

class EducationDsImp implements EducationDs {
  final ApiClient apiClient;
  EducationDsImp(this.apiClient);

  @override
  Future<EducationModel> educationDropDs() async {
    final result =
        await apiClient.request(path: ApiConst.EDUCATION, type: 'get');
    return EducationModel.fromJson(result['data']);
  }
}

final educationDSProvider = Provider<EducationDs>((ref) {
  return EducationDsImp(ref.read(apiClientProvider));
});
