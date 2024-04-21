import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shramsansar/core/api_client/api_client.dart';
import 'package:shramsansar/core/api_const/api_const.dart';
import 'package:shramsansar/features/getDocumentType/data/models/document_type_model.dart';

abstract class DocumentTypeDataSource {
  Future<DocumentTypeModel> getDocumentType();
}

class DocumentTypeDataSourceImp implements DocumentTypeDataSource {
  final ApiClient apiClient;
  DocumentTypeDataSourceImp(this.apiClient);

  @override
  Future<DocumentTypeModel> getDocumentType() async {
    final result = await apiClient.request(path: ApiConst.DOCOMENT_TYPE);

    log("Result: $result");
    return DocumentTypeModel.fromJson(result);
  }
}

final documentTypeDataSourceProvider = Provider<DocumentTypeDataSource>((ref) {
  return DocumentTypeDataSourceImp(ref.read(apiClientProvider));
});
