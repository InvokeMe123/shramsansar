import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shramsansar/core/app_error/app_error.dart';
import 'package:shramsansar/features/edit_profile/data/data_source/social_account_data_source/social_account_data_source.dart';
import 'package:shramsansar/features/edit_profile/data/models/social_accounts_model/add_social_accounts.dart';
import 'package:shramsansar/features/edit_profile/data/models/social_accounts_model/social_accounts_model.dart';

abstract class SocialAccountsRepo {
  Future<Either<AppError, SocialAccountsModel>> getSocialAccounts();
  Future<Either<AppError, void>> addSocialAccount(AddSocialAccountsModel model);
}

class SocialAccountsRepoImpl implements SocialAccountsRepo {
  final SocialAccountDataSource socialAccountDataSource;

  SocialAccountsRepoImpl({required this.socialAccountDataSource});

  @override
  Future<Either<AppError, SocialAccountsModel>> getSocialAccounts() async {
    try {
      final socialAccounts = await socialAccountDataSource.getSocialAccounts();
      return Right(socialAccounts);
    } catch (e) {
      return Left(AppError(e.toString()));
    }
  }

  @override
  Future<Either<AppError, void>> addSocialAccount(
      AddSocialAccountsModel model) async {
    try {
      final result = await socialAccountDataSource.addSocialAccount(model);
      return const Right(null);
    } catch (e) {
      return Left(AppError(e.toString()));
    }
  }
}

final socialAccountsRepoProvider = Provider<SocialAccountsRepo>(
  (ref) => SocialAccountsRepoImpl(
      socialAccountDataSource: ref.read(socialAccountDataSourceProvider)),
);
