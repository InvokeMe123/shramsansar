import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:number_pagination/number_pagination.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shramsansar/const/app_color_const.dart';
import 'package:shramsansar/features/all_jobs/provider/page_index_provider.dart';
import 'package:shramsansar/features/trainings/provider/page_index_provider.dart';

class PaginationCard2 extends ConsumerWidget {
  final int totalItems;
  final int perPage;
  const PaginationCard2(
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
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      height: 7.h,
      child: NumberPagination(
        onPageChanged: (int pageNumber) {
          ref.read(pageIndexProvider1.notifier).update((state) => pageNumber);
        },

        threshold: perPage,
        pageTotal: findTotalPage(),
        pageInit: ref.watch(pageIndexProvider1), // picked number when init page
        colorPrimary: Colors.white,
        colorSub: AppColorConst.BUTTON_BLUE_COLOR,
      ),
    );
  }
}
