import 'package:flutter/material.dart';
import 'package:shramsansar/const/app_color_const.dart';
import 'package:shramsansar/features/display_training/presentation/views/display_training.dart';
import 'package:shramsansar/features/trainings/data/models/training_model/training_model.dart';
import 'package:shramsansar/utils/navigation/nav_app.dart';

class TrainingCard extends StatelessWidget {
  final Data model;

  const TrainingCard({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        normalNav(context, DisplayTraining(dataModel: model));
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        elevation: 0,
        color: Colors.grey.shade100,
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(model.title.toString(),
                    style: TextStyle(
                        fontSize: 16,
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.bold,
                        color: AppColorConst.BUTTON_BLUE_COLOR)),
                const SizedBox(height: 4),
                Text(
                  model.serviceProviderName.toString(),
                  style: const TextStyle(
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Date
                    Row(
                      children: [
                        const Icon(Icons.calendar_month_outlined, size: 18),
                        Text("${model.startDate} - ${model.endDate}",
                            style: const TextStyle(
                                overflow: TextOverflow.ellipsis, fontSize: 12))
                      ],
                    ),

                    Row(
                      children: [
                        const Icon(Icons.location_on_outlined, size: 18),
                        Text("${model.districtName}",
                            style: const TextStyle(
                                overflow: TextOverflow.ellipsis, fontSize: 12))
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.access_time, size: 18),
                        Text("${model.startTime} - ${model.endTime}",
                            style: const TextStyle(fontSize: 12))
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
