import 'package:flutter/material.dart';
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
                      Text("${model.startDate} - ${model.endDate}",
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
                      Text("${model.startTime} - ${model.endTime}",
                          style: TextStyle(fontSize: 12))
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
