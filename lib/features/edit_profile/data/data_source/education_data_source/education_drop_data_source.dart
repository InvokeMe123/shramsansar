import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shramsansar/core/api_client/api_client.dart';
import 'package:shramsansar/core/api_const/api_const.dart';
import 'package:shramsansar/features/edit_profile/data/models/education_model/education_model.dart';
import 'package:shramsansar/features/edit_profile/data/models/education_model/education_model_req.dart';
import 'package:shramsansar/features/edit_profile/data/models/education_model/education_model_res.dart';

abstract class EducationDs {
  Future<EducationModel> educationDropDs();
  Future<EducationResModel> educationAdd(EducationReqModel educationReqModel);
  Future<EducationResModel> educationDelete(int id);
}

class EducationDsImp implements EducationDs {
  final ApiClient apiClient;
  EducationDsImp(this.apiClient);

  @override
  Future<EducationModel> educationDropDs() async {
    final result =
        await apiClient.request(path: ApiConst.EDUCATION, type: 'get');
    return EducationModel.fromJson(result);
  }

  @override
  Future<EducationResModel> educationAdd(
      EducationReqModel educationReqModel) async {
    final result = await apiClient.request(
        path: ApiConst.POST_EDUCATION,
        type: 'post',
        data: educationReqModel.toMap());
    return EducationResModel.fromJson(result['message']);
  }

  @override
  Future<EducationResModel> educationDelete(int id) async {
    final result = await apiClient.request(
        path: '${ApiConst.DELETE_EDUCATION}$id', type: 'get');
    return EducationResModel.fromJson(result['message']);
  }
}

final educationDSProvider = Provider<EducationDs>((ref) {
  return EducationDsImp(ref.read(apiClientProvider));
});
