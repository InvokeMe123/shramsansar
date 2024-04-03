import 'package:flutter/material.dart';

import 'package:flutter_html/flutter_html.dart';
import 'package:shramsansar/features/all_jobs/data/models/all_jobs_model.dart';

class DisplayJob extends StatelessWidget {
  final Data dataModel;
  const DisplayJob({super.key, required this.dataModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Training Details'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(dataModel.title.toString()),
              TextButton(
                onPressed: () {},
                child: const Text('Apply Now'),
              ),
            ],
          ),
          Divider(),
          Text("Company's details"),
          Text(dataModel.serviceProviderName.toString()),
          Row(
            children: [
              const Icon(Icons.location_on_outlined, size: 18),
              Text(dataModel.districtName.toString(),
                  style: TextStyle(fontSize: 12)),
              Text(", ${dataModel.muniName}", style: TextStyle(fontSize: 12))
            ],
          ),
          Row(
            children: [
              const Icon(Icons.phone_outlined, size: 18),
              Text(dataModel.serviceProvider!.mobile.toString(),
                  style: TextStyle(fontSize: 12))
            ],
          ),
          Row(
            children: [
              const Icon(Icons.email_outlined, size: 18),
              Text(dataModel.serviceProvider!.email.toString(),
                  style: TextStyle(fontSize: 12))
            ],
          ),
          const Text("Test details"),
          Row(
            children: [
              const Icon(Icons.location_on_outlined, size: 18),
              Text(dataModel.districtName.toString(),
                  style: TextStyle(fontSize: 12)),
              Text(", ${dataModel.muniName}", style: TextStyle(fontSize: 12)),
            ],
          ),
          Row(
            children: [
              const Icon(Icons.people_alt_outlined, size: 18),
              Text(dataModel.address.toString(), style: TextStyle(fontSize: 12))
            ],
          ),
          Row(
            children: [
              const Icon(Icons.calendar_month_outlined, size: 18),
              Text("${dataModel.description} ",
                  style: const TextStyle(fontSize: 12))
            ],
          ),
          Row(
            children: [
              const Icon(Icons.access_time, size: 18),
              Text("${dataModel.deadline} - ${dataModel.engDeadline}",
                  style: TextStyle(fontSize: 12))
            ],
          ),
          Html(
            data: dataModel.description.toString(),
            shrinkWrap: true,
            style: {
              "*": Style(
                fontSize: FontSize(12),
              ),
            },
          ),
        ],
      ),
    );
  }
}
