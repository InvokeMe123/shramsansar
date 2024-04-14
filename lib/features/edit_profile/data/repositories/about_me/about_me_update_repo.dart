import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shramsansar/core/app_error/app_error.dart';
import 'package:shramsansar/features/edit_profile/data/data_source/about_me_update/about_me_update_ds.dart';
import 'package:shramsansar/features/edit_profile/data/models/about_me_update_model/about_me_update_req_model.dart';
import 'package:shramsansar/features/edit_profile/data/models/about_me_update_model/about_me_update_res_model.dart';

abstract class AboutMeUpdateRepo {
  Future<Either<AppError, AboutMeUpdateResModel>> aboutMeUpdateRepo(
      AboutMeUpdateReqModel aboutMeUpdateReqModel);
}

class AboutMeUpdateRepoImp implements AboutMeUpdateRepo {
  final AboutMeUpdateDs aboutMeUpdateDs;
  AboutMeUpdateRepoImp(this.aboutMeUpdateDs);

  @override
  Future<Either<AppError, AboutMeUpdateResModel>> aboutMeUpdateRepo(
      AboutMeUpdateReqModel aboutMeUpdateReqModel) async {
    try {
      final result =
          await aboutMeUpdateDs.updateAboutMeDs(aboutMeUpdateReqModel);
      return Right(result);
    } on DioException catch (e) {
      return Left(AppError(e.message!));
    }
  }
}

final aboutMeUpdateRepoProvider = Provider<AboutMeUpdateRepo>((ref) {
  return AboutMeUpdateRepoImp(ref.read(aboutMeUpdateDsProvider));
});
