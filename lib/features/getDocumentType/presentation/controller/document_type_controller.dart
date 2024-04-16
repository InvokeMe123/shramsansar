import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shramsansar/features/getDocumentType/data/models/document_type_model.dart';
import 'package:shramsansar/features/getDocumentType/data/repository/document_type_repository.dart';

class DocumentTypeController
    extends StateNotifier<AsyncValue<DocumentTypeModel>> {
  final DocumentTypeRepo _documentTypeRepo;
  DocumentTypeController(this._documentTypeRepo)
      : super(const AsyncValue.loading()) {
    getDocumentType();
  }

  getDocumentType() async {
    final result = await _documentTypeRepo.getDocumentType();
    result.fold((l) {
      state = AsyncValue.error(l, StackTrace.fromString(l.message));
    }, (r) {
      state = AsyncValue.data(r);
    });
  }
}

final documentTypeControllerProvider = StateNotifierProvider<
    DocumentTypeController, AsyncValue<DocumentTypeModel>>((ref) {
  return DocumentTypeController(ref.read(documentTypeRepoProvider));
});
