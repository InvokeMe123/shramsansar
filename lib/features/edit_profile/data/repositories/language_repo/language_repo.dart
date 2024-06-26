import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shramsansar/core/app_error/app_error.dart';
import 'package:shramsansar/features/edit_profile/data/data_source/language_data_source/language_data_source.dart';
import 'package:shramsansar/features/edit_profile/data/models/language_model/language_model.dart';

abstract class LanguageRepo {
  Future<Either<AppError, void>> addLanguage(LanguageModel language);
  Future<Either<AppError, void>> deleteLanguage(int id);
  Future<Either<AppError, void>> updateLanguage(LanguageModel language);
}

class LanguageRepoImpl implements LanguageRepo {
  final LanguageDataSource languageDataSource;

  LanguageRepoImpl({required this.languageDataSource});

  @override
  Future<Either<AppError, void>> addLanguage(LanguageModel language) async {
    try {
      await languageDataSource.addLanguage(language);
      return const Right(null);
    } catch (e) {
      return Left(AppError(e.toString()));
    }
  }

  @override
  Future<Either<AppError, void>> deleteLanguage(int id) async {
    try {
      await languageDataSource.deleteLanguage(id);
      return const Right(null);
    } catch (e) {
      return Left(AppError(e.toString()));
    }
  }

  @override
  Future<Either<AppError, void>> updateLanguage(LanguageModel language) async {
    try {
      await languageDataSource.updateLanguage(language);
      return const Right(null);
    } catch (e) {
      return Left(AppError(e.toString()));
    }
  }
}

final languageRepoProvider = Provider<LanguageRepo>((ref) {
  return LanguageRepoImpl(
      languageDataSource: ref.read(languageDataSourceProvider));
});
