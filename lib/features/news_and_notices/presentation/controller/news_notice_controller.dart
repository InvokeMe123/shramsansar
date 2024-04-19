import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shramsansar/features/news_and_notices/data/models/news_notice_model.dart';
import 'package:shramsansar/features/news_and_notices/data/repository/news_notice_repo.dart';

class NewsNoticeController extends StateNotifier<AsyncValue<NewsNoticeModel>> {
  final NewsNoticeRepo newsNoticeRepo;
  int page;
  NewsNoticeController(this.newsNoticeRepo, this.page)
      : super(const AsyncValue.loading()) {
    getNewsNotice();
  }

  getNewsNotice() async {
    final result = await newsNoticeRepo.newsnoticeRepo(page);
    result.fold(
        (l) => state =
            AsyncValue.error(l.message, StackTrace.fromString(l.message)),
        (r) => state = AsyncValue.data(r));
  }

  filterNewsNotice({required String title, required String type}) async {
    final result = await newsNoticeRepo.filter(title: title, type: type);
    result.fold(
        (l) => state =
            AsyncValue.error(l.message, StackTrace.fromString(l.message)), (r) {
      state = AsyncValue.data(r);
    });
  }
}

final newsnoticeControllerProvider = StateNotifierProvider.family<
    NewsNoticeController, AsyncValue<NewsNoticeModel>, int>((ref, page) {
  return NewsNoticeController(ref.read(newsnoticeRepoProvider), page);
});
