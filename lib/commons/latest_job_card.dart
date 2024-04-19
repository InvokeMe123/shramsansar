import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shramsansar/const/app_color_const.dart';
import 'package:shramsansar/core/api_const/api_const.dart';
import 'package:shramsansar/features/all_jobs/data/models/latest_job_model.dart';
import 'package:shramsansar/features/all_jobs/presentation/views/display_latest_job_detail.dart';
import 'package:shramsansar/utils/navigation/nav_app.dart';

class LatestJobCard extends StatelessWidget {
  final Data data;
  const LatestJobCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        normalNav(context, LatestJobDisplay(dataModel: data));
      },
      child: Card(
        elevation: 0,
        color: Colors.grey.shade100,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6.0),
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Image(
                image: NetworkImage('${ApiConst.IMAGE_URL}${data.serviceProvider!.logo}')),
            title: Text(
              data.title!,
              style: TextStyle(
                  color: AppColorConst.BUTTON_BLUE_COLOR,
                  fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.serviceProviderName!,
                  style: TextStyle(color: Colors.black, fontSize: 14.sp),
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      size: 14,
                    ),
                    Text(
                      '${data.serviceProvider!.muniName!} ,${data.serviceProvider!.districtName!}',
                      style: TextStyle(color: Colors.black, fontSize: 14.sp),
                    ),
                  ],
                ),
              ],
            ),
            trailing: SizedBox(
                width: 20.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(
                      Icons.watch_later_outlined,
                      size: 18,
                    ),
                    Text(data.deadline.toString()),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
