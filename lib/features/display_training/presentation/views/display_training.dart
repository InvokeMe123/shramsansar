import 'package:flutter/material.dart';
import 'package:shramsansar/features/trainings/data/models/training_model/training_model.dart';
import 'package:flutter_html/flutter_html.dart';

class DisplayTraining extends StatelessWidget {
  final Data dataModel;
  const DisplayTraining({super.key, required this.dataModel});

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
              Text(dataModel.noOfParticipant.toString(),
                  style: TextStyle(fontSize: 12))
            ],
          ),
          Row(
            children: [
              const Icon(Icons.calendar_month_outlined, size: 18),
              Text("${dataModel.startDate} to ${dataModel.endDate}",
                  style: const TextStyle(fontSize: 12))
            ],
          ),
          Row(
            children: [
              const Icon(Icons.access_time, size: 18),
              Text("${dataModel.startTime} - ${dataModel.endTime}",
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
