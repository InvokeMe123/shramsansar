import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shramsansar/const/app_color_const.dart';
import 'package:shramsansar/core/api_const/api_const.dart';
import 'package:shramsansar/features/all_jobs/data/models/all_jobs_model.dart';
import 'package:shramsansar/features/all_jobs/presentation/views/display_job_detail.dart';

import 'package:shramsansar/utils/navigation/nav_app.dart';

class JobCard extends StatelessWidget {
  final Data model;

  const JobCard({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        normalNav(context, DisplayJob(dataModel: model));
      },
      child: Card(
        elevation: 0,
        color: CupertinoColors.extraLightBackgroundGray,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Row(
            children: [
              Image(
                  width: 23.w,
                  image: NetworkImage(
                      '${ApiConst.IMAGE_URL}${model.serviceProvider!.logo!}')),
              const SizedBox(
                width: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(model.title.toString(),
                      style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColorConst.BUTTON_BLUE_COLOR)),
                  const SizedBox(height: 4),
                  Text(model.serviceProviderName.toString()),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Date
                      Row(
                        children: [
                          const Icon(Icons.calendar_month_outlined, size: 18),
                          Text("${model.address}",
                              style: const TextStyle(fontSize: 12))
                        ],
                      ),

                      Row(
                        children: [
                          const Icon(Icons.location_on_outlined, size: 18),
                          Text("${model.districtName}",
                              style: const TextStyle(fontSize: 12))
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.access_time, size: 18),
                          Text("${model.deadline}",
                              style: const TextStyle(fontSize: 12))
                        ],
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
