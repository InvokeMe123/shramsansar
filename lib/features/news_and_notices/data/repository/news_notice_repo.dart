import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shramsansar/core/app_error/app_error.dart';
import 'package:shramsansar/features/news_and_notices/data/data_source/news_notices_data_source.dart';
import 'package:shramsansar/features/news_and_notices/data/models/news_notice_model.dart';

abstract class NewsNoticeRepo {
  Future<Either<AppError, NewsNoticeModel>> newsnoticeRepo(int page);
  Future<Either<AppError, NewsNoticeModel>> filter(
      {required String title, required String type});
}

class NewsNoticeRepoImp implements NewsNoticeRepo {
  final NewsNoticeDs newsNoticeDs;
  NewsNoticeRepoImp(this.newsNoticeDs);

  @override
  Future<Either<AppError, NewsNoticeModel>> newsnoticeRepo(int page) async {
    try {
      final result = await newsNoticeDs.newsNoticeDs(page);
      return Right(result);
    } on DioException catch (e) {
      return Left(AppError(e.message!));
    }
  }

  @override
  Future<Either<AppError, NewsNoticeModel>> filter(
      {required String title, required String type}) async {
    try {
      final result = await newsNoticeDs.filter(title: title, type: type);
      return Right(result);
    } on DioException catch (e) {
      return Left(AppError(e.message!));
    }
  }
}

final newsnoticeRepoProvider = Provider<NewsNoticeRepo>((ref) {
  return NewsNoticeRepoImp(ref.read(newsnoticeDsProvider));
});
