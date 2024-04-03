import 'package:flutter/material.dart';
import 'package:shramsansar/features/all_jobs/data/models/all_jobs_model.dart';
import 'package:shramsansar/features/all_jobs/presentation/views/display_job_detail.dart';
import 'package:shramsansar/features/display_training/presentation/views/display_training.dart';

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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(model.title.toString(),
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue)),
              const SizedBox(height: 4),
              Text(model.serviceProviderName.toString()),
              SizedBox(height: 6),
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
                          style: TextStyle(fontSize: 12))
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.access_time, size: 18),
                      Text("${model.deadline}", style: TextStyle(fontSize: 12))
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
