import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shramsansar/core/api_client/api_client.dart';
import 'package:shramsansar/core/api_const/api_const.dart';
import 'package:shramsansar/features/news_and_notices/data/models/news_notice_model.dart';

abstract class NewsNoticeDs {
  Future<NewsNoticeModel> newsNoticeDs(int page);
}

class NewsNoticeDsImp implements NewsNoticeDs {
  final ApiClient apiClient;
  NewsNoticeDsImp(this.apiClient);

  @override
  Future<NewsNoticeModel> newsNoticeDs(int page) async {
    final result = await apiClient.request(path: "${ApiConst.NEW_NOTICE}$page");
    return NewsNoticeModel.fromJson(result['data']);
  }
}

final newsnoticeDsProvider = Provider<NewsNoticeDs>((ref) {
  return NewsNoticeDsImp(ref.read(apiClientProvider));
});
