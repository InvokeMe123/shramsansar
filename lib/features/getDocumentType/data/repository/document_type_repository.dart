import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shramsansar/core/app_error/app_error.dart';
import 'package:shramsansar/features/getDocumentType/data/data_source/document_type_data_source.dart';
import 'package:shramsansar/features/getDocumentType/data/models/document_type_model.dart';

abstract class DocumentTypeRepo {
  Future<Either<AppError, DocumentTypeModel>> getDocumentType();
}

class DocumentTypeRepoImp implements DocumentTypeRepo {
  final DocumentTypeDataSource documentTypeDataSource;
  DocumentTypeRepoImp(this.documentTypeDataSource);

  @override
  Future<Either<AppError, DocumentTypeModel>> getDocumentType() async {
    try {
      final result = await documentTypeDataSource.getDocumentType();
      return Right(result);
    } catch (e) {
      return Left(AppError(e.toString()));
    }
  }
}

final documentTypeRepoProvider = Provider<DocumentTypeRepo>((ref) {
  return DocumentTypeRepoImp(ref.read(documentTypeDataSourceProvider));
});
