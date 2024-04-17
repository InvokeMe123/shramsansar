import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shramsansar/const/app_color_const.dart';
import 'package:shramsansar/core/api_client/api_client.dart';
import 'package:shramsansar/core/api_const/api_const.dart';
import 'package:shramsansar/core/dbclient.dart';
import 'package:shramsansar/features/trainings/data/data_source/apply_for_training_ds.dart';
import 'package:shramsansar/features/trainings/data/models/training_model/training_model.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:shramsansar/features/trainings/presentation/controller/apply_for_training_controller.dart';

class DisplayTraining extends ConsumerWidget {
  final Data dataModel;
  const DisplayTraining({super.key, required this.dataModel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Training Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  dataModel.title.toString(),
                  style: TextStyle(
                      color: AppColorConst.BUTTON_BLUE_COLOR,
                      fontWeight: FontWeight.bold,
                      fontSize: 24),
                ),
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                      color: AppColorConst.BUTTON_BLUE_COLOR,
                      borderRadius: BorderRadius.circular(4)),
                  child: TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Apply Now'),
                            content:
                                const Text('Are you sure you want to apply?'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('No'),
                              ),
                              TextButton(
                                onPressed: () {
                                  ref
                                      .read(applyForTrainingControllerProvider
                                          .notifier)
                                      .applyForTraining(
                                          trainingID: dataModel.id.toString());

                                  final applyResult = ref.watch(
                                      applyForTrainingControllerProvider);

                                  applyResult.when(
                                      data: (data) {
                                        Navigator.of(context).pop();
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(content: Text(data)),
                                        );
                                      },
                                      loading: () {},
                                      error: (error, stackTrace) {
                                        debugPrint("Appliied failed");
                                      });
                                },
                                child: const Text('Yes'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Text(
                      'Apply Now',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            Divider(),
            Center(
              child: Text(
                "Company's details",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
            Row(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  child: Image(
                    image: NetworkImage('${ApiConst.IMAGE_URL}' +
                        dataModel.serviceProvider!.logo.toString()),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  width: MediaQuery.sizeOf(context).width * .70,
                  child: Text(
                    dataModel.serviceProviderName.toString(),
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontSize: 16),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Icon(Icons.location_on_outlined, size: 18),
                SizedBox(
                  width: 5,
                ),
                Text(dataModel.districtName.toString(),
                    style: TextStyle(fontSize: 12)),
                Text(", ${dataModel.muniName}", style: TextStyle(fontSize: 12))
              ],
            ),
            Row(
              children: [
                const Icon(Icons.phone_outlined, size: 18),
                SizedBox(
                  width: 5,
                ),
                Text(dataModel.serviceProvider!.mobile.toString(),
                    style: TextStyle(fontSize: 12))
              ],
            ),
            Row(
              children: [
                const Icon(Icons.email_outlined, size: 18),
                SizedBox(
                  width: 5,
                ),
                Text(dataModel.serviceProvider!.email.toString(),
                    style: TextStyle(fontSize: 12))
              ],
            ),
            Divider(),
            const Text("Test details"),
            Row(
              children: [
                const Icon(Icons.location_on_outlined, size: 18),
                SizedBox(
                  width: 5,
                ),
                Text(dataModel.districtName.toString(),
                    style: TextStyle(fontSize: 12)),
                Text(", ${dataModel.muniName}", style: TextStyle(fontSize: 12)),
              ],
            ),
            Row(
              children: [
                const Icon(Icons.people_alt_outlined, size: 18),
                SizedBox(
                  width: 5,
                ),
                Text(dataModel.noOfParticipant.toString(),
                    style: TextStyle(fontSize: 12))
              ],
            ),
            Row(
              children: [
                const Icon(Icons.calendar_month_outlined, size: 18),
                SizedBox(
                  width: 5,
                ),
                Text("${dataModel.startDate} to ${dataModel.endDate}",
                    style: const TextStyle(fontSize: 12))
              ],
            ),
            Row(
              children: [
                const Icon(Icons.access_time, size: 18),
                SizedBox(
                  width: 5,
                ),
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
      ),
    );
  }
}
