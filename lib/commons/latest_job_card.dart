import 'package:flutter/material.dart';
import 'package:shramsansar/core/api_const/api_const.dart';
import 'package:shramsansar/features/all_jobs/data/models/latest_job_model.dart';
import 'package:shramsansar/features/all_jobs/presentation/views/display_latest_job_detail.dart';
import 'package:shramsansar/utils/navigation/nav_app.dart';

class LatestJobCard extends StatelessWidget {
  final Data data;
  LatestJobCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        normalNav(context, LatestJobDisplay(dataModel: data));
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            tileColor: Colors.white,
            leading: Container(
              width: 50,
              height: 100,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage('${ApiConst.IMAGE_URL}' +
                          data.serviceProvider!.logo.toString()))),
            ),
            title: Text(
              data.title!,
              style: TextStyle(color: Colors.black),
            ),
            subtitle: Text(data.serviceProviderName!),
          ),
        ),
      ),
    );
  }
}
