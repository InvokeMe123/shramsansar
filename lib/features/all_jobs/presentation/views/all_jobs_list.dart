import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shramsansar/const/app_color_const.dart';
import 'package:shramsansar/const/app_image_const.dart';
import 'package:shramsansar/core/api_const/api_const.dart';
import 'package:shramsansar/features/all_jobs/data/models/all_jobs_model.dart';

// ignore: must_be_immutable
class AllJobList extends ConsumerWidget {
  Data viewAllJobsData;
  AllJobList(this.viewAllJobsData, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
        onTap: () {},
        child: Container(
          margin: EdgeInsets.only(
            left: 10,
            right: 10,
            bottom: 5,
            top: 5,
          ),
          width: double.infinity,
          height: MediaQuery.sizeOf(context).height * 0.12,
          child: Row(
            children: [
              Column(
                children: [
                  viewAllJobsData.serviceProvider!.logo != null
                      ? CachedNetworkImage(
                          imageUrl:
                              '${ApiConst.URL}${viewAllJobsData.serviceProvider!.logo}',
                          width: 80,
                          height: 80,
                          placeholder: (context, url) =>
                              Image.asset(AppImagesConst.place_holder),
                          errorWidget: (context, url, error) =>
                              Image.asset(AppImagesConst.place_holder),
                        )
                      : Image.asset(AppImagesConst.place_holder)
                ],
              ),
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(),
                    width: MediaQuery.of(context).size.width - 120,
                    child: Text(
                      '${viewAllJobsData.title}',
                      maxLines: 1,
                      style: TextStyle(
                          fontSize: 18,
                          color: AppColorConst.PRAYMARY_TEXT_COLOR),
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.only(left: 10, top: 5),
                      width: MediaQuery.of(context).size.width - 120,
                      child: Text(
                        '${viewAllJobsData.serviceProviderName}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(),
                      )),
                ],
              )
            ],
          ),
        ));
  }
}
