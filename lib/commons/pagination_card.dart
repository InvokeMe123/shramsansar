import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_pagination/flutter_pagination.dart';
import 'package:flutter_pagination/widgets/button_styles.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:number_pagination/number_pagination.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shramsansar/features/trainings/provider/page_index_provider.dart';

class PaginationCard extends ConsumerWidget {
  final int totalItems;
  final int perPage;
  const PaginationCard(
      {super.key, required this.totalItems, required this.perPage});

  int findTotalPage() {
    double totalPage = totalItems / 10;

    if (totalPage % 1 != 0) {
      totalPage = totalPage.toInt() + 1;
    }

    return totalPage.toInt();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // return Pagination(
    //   width: 40.w,
    //   height: 5.h,
    //   paginateButtonStyles: PaginateButtonStyles(),
    //   prevButtonStyles: PaginateSkipButton(
    //       borderRadius: const BorderRadius.only(
    //           topLeft: Radius.circular(20), bottomLeft: Radius.circular(20))),
    //   nextButtonStyles: PaginateSkipButton(
    //       borderRadius: const BorderRadius.only(
    //           topRight: Radius.circular(20), bottomRight: Radius.circular(20))),
    //   onPageChange: (number) {
    //     ref.read(pageIndexProvider.notifier).update((state) => number);
    //   },
    //   useGroup: true,
    //   totalPage: findTotalPage(),
    //   show: findTotalPage() - 1,
    //   currentPage: ref.watch(pageIndexProvider),
    // );

    return NumberPagination(
      onPageChanged: (int pageNumber) {
        ref.read(pageIndexProvider.notifier).update((state) => pageNumber);
      },

      threshold: perPage,
      pageTotal: findTotalPage(),
      pageInit: ref.watch(pageIndexProvider), // picked number when init page
      colorPrimary: Colors.red,
      colorSub: Colors.yellow,
    );
  }
}
