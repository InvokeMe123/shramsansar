import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shramsansar/core/app_error/app_error.dart';
import 'package:shramsansar/features/edit_profile/data/data_source/about_me_update/about_me_update_ds.dart';
import 'package:shramsansar/features/edit_profile/data/data_source/about_me_update/about_you_ds.dart';
import 'package:shramsansar/features/edit_profile/data/models/about_me_update_model/about_me_update_req_model.dart';
import 'package:shramsansar/features/edit_profile/data/models/about_me_update_model/about_me_update_res_model.dart';

import '../../models/about_me_update_model/about_me_model.dart';

abstract class AboutYouRepo {
  Future<Either<AppError, AboutMeModel>> aboutYouRepo();
}

class AboutYouRepoImp implements AboutYouRepo {
  final AboutYouDs aboutYouDs;
  AboutYouRepoImp(this.aboutYouDs);
  @override
  Future<Either<AppError, AboutMeModel>> aboutYouRepo() async {
    try {
      final result = await aboutYouDs.aboutYou();
      return Right(result);
    } on DioException catch (e) {
      return Left(AppError(e.message!));
    }
  }
}

final aboutYouRepoProvider = Provider<AboutYouRepo>((ref) {
  return AboutYouRepoImp(ref.read(aboutYouDsProvider));
});
