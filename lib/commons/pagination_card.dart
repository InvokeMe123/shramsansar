import 'package:flutter/widgets.dart';
import 'package:flutter_pagination/flutter_pagination.dart';
import 'package:flutter_pagination/widgets/button_styles.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shramsansar/features/trainings/provider/page_index_provider.dart';

class PaginationCard extends ConsumerWidget {
  final int totalItems;
  const PaginationCard({super.key, required this.totalItems});

  int findTotalPage() {
    double totalPage = totalItems / 10;

    if (totalPage % 1 != 0) {
      totalPage = totalPage.toInt() + 1;
    }

    return totalPage.toInt();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Pagination(
      width: 40.w,
      height: 5.h,
      paginateButtonStyles: PaginateButtonStyles(),
      prevButtonStyles: PaginateSkipButton(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20), bottomLeft: Radius.circular(20))),
      nextButtonStyles: PaginateSkipButton(
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(20), bottomRight: Radius.circular(20))),
      onPageChange: (number) {
        ref.read(pageIndexProvider.notifier).update((state) => number);
      },
      useGroup: true,
      totalPage: findTotalPage() + 1,
      show: findTotalPage(),
      currentPage: ref.watch(pageIndexProvider),
    );
  }
}
